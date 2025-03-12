package kr.or.ddit.recruit.service.dto;

import lombok.Data;

@Data
public class SearchRequest {
  private int page;
  private String searchWord;
  private String status;
}