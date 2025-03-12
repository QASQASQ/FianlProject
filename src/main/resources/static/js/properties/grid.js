/**
 *  grid.js 
 */
/**
const grid = new tui.Grid({
	el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    data: initialData, // 초기 데이터 설정
    rowHeaders: ['rowNum', 'checkbox'],
	header: {
    	height: 100,
	},
    columns: [ 
    	
        { header: '물품번호', name: 'propNo', width: 150 , sortingType: 'desc', sortable: true},
        { header: '물품분류코드', name: 'psCode', sortingType: 'asc', sortable: true},
        { header: '물품명', name: 'propName', sortingType: 'asc', sortable: true },
        { header: '물품설명', name: 'propContent', sortingType: 'asc', sortable: true},
		{ header: '물품수량', name: 'propQty', editor: 'text' , sortingType: 'asc', sortable: true},
		{ header: '파일식별번호', name: 'fileIdentify', sortingType: 'asc', sortable: true}
    ], // columns
    pageOptions: {
        useClient: true,
        perPage: 5
    }
});
*/

const grid = new tui.Grid({
    el: document.getElementById('grid'),
    scrollX: false,
    scrollY: false,
    data: initialData, // 초기 데이터 설정
    rowHeaders: ['rowNum', 'checkbox'],
    header: {
        height: 100,
    },
    columns: [ 
        { header: '물품분류코드', name: 'psCode', editor: 'text', sortingType: 'asc', sortable: true },
        { header: '물품명', name: 'propName', editor: 'text', sortingType: 'asc', sortable: true },
        { header: '물품설명', name: 'propContent', editor: 'text', sortingType: 'asc', sortable: true },
        { header: '물품수량', name: 'propQty', editor: 'text', sortingType: 'asc', sortable: true },
		{ header: '파일식별번호', name: 'fileIdentify', editor: 'text', sortingType: 'asc', sortable: true }
    ],
    pageOptions: {
        useClient: true,
        perPage: 15
    }
});
