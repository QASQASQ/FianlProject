package kr.or.ddit.pay.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.pay.mapper.IPayStubMapper;
import kr.or.ddit.pay.service.IPayStubService;
import kr.or.ddit.pay.vo.PayStubVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PayStubServiceImpl implements IPayStubService {

    @Autowired
    private IPayStubMapper mapper;

    @Override
    public List<PayStubVO> getMyPayStubs(String emplNo, String yearr, String monthh, String dayy) {
        return mapper.selectMyPayStubs(emplNo, yearr, monthh, dayy);
    }

    @Override
    public Map<String, Object> getPayStub(String emplNo) throws Exception {
        try {
            Map<String, Object> payStub = mapper.getPaidPayStub(emplNo);

            // 지급된 명세서가 없으면 미리보기 생성 및 조회
            if (payStub == null) {
                mapper.generatePayStubPreview(emplNo);
                payStub = mapper.getPayStubPreview(emplNo);
            }
            return payStub;
        } catch (Exception e) {
            throw new Exception("급여 명세서 조회 중 오류 발생", e);
        }
    }

    @Transactional
    @Override
    public void paySalary(List<String> emplNos) {
        for (String emplNo : emplNos) {
            log.info("💳 급여 지급 대상 사원번호: " + emplNo);

            // 1️⃣ 기존 미리보기 데이터 삭제
            mapper.deletePreviewPayStub(emplNo);

            // 2️⃣ 프로시저 호출하여 급여명세서 생성
            mapper.generatePayStub(emplNo);

            // 3️⃣ PAY_AT 상태를 'Y'로 업데이트
            mapper.updatePayStatus(emplNo);
        }
    }
}