$(function(){
	var form=$("#bookAddForm").Validform({
		tiptype:2,//validform初始化
	});
	
	form.addRule([
		{
			ele:"#bookName",
		    datatype:"*2-100",
		    ajaxurl:"jsp/admin/BookManageServlet?action=find",
		    nullmsg:"请输入商品名！",
		    errormsg:"商品名至少2个字符,最多20个字符！"
		},
		{ 
			ele:"#catalog",
			datatype:"*",
			nullmsg:"请选择商品分类！",
			errormsg:"请选择商品分类！"
		},
		{
			ele:"#price",
			datatype:"/^[0-9]{1,}([.][0-9]{1,2})?$/",
			mullmsg:"价格不能为空！",
			errormsg:"价格只能为数字"
		},
		{
			ele:"#author",
		    datatype:"*2-30",
		    nullmsg:"请输入卖方id！",
		    errormsg:"商品品牌至少2个字符,最多30个字符！"
		},
		{
			ele:"#press",
		    nullmsg:"请输入使用时长！"

		},
		{
			ele:"#bookVid",
			datatype:"*",
			nullmsg:"请上传商品视频！",
			errormsg:"请上传商品视频！"
		},
		{
			ele:"#bookImg", 
		    datatype:"*",
		    nullmsg:"请上传商品图片！",
		    errormsg:"请上传商品图片！"
		},
		{
			ele:"#bookVid",
			datatype:"*",
			nullmsg:"请上传商品视频！",
			errormsg:"请上传商品视频！"
		}
	
	]);
	
});
