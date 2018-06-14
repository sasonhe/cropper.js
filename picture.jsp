<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set value="${pageContext.request.contextPath}" var="ctx"></c:set>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>演示项目Demo</title>
    <meta name="keywords" />
    <meta name="description" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="${ctx}/pub/de-css/cropper.css">
    <link rel="stylesheet" href="${ctx}/pub/de-css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/pub/de-css/ex_index.css">
  </head>
  <body>
    <div class="mainBox">
      <form name="form-apply" id="form-apply">
        <input name="photeGuid" id="photeGuid" type="hidden" />
    
        <input type="hidden" value="${personGuid}" name="personGuid" id="personGuid" />
        <input type="hidden" value="10023" name="expoId" id="expoId" />
        <section>
          <div class="crop">
            <div><img src="" alt="" id="image" class="img-respone" style="height:6.2rem;opacity:0;"></div>
            <div class="tips_text">
              <h2 class="title border-1px m-b">人像采集注意事项</h2>
              <div class="info m-b">
                <p>1、照片中不能有多人</p>
                <p>2、照片人脸不能遮挡</p>
                <p>3、照片不能模糊</p>
                <p>4、人脸姿态端正</p>
                <p>5、不能带墨镜</p>
                <p>6、照片侧脸角度不能过大</p>
              </div>
              <div class="desc">
                <h2 class="border-1px m-b">说明：</h2>
                <p>人像采集后，进场时使用人脸识别即可通过闸机</p>
                <p>请到光线充足的环境下拍照，脸部清晰，无遮挡物</p>
                <p>裁剪时可通过拖动裁剪框变化大小，双指缩放照片</p>
                <p>裁剪框外可上下左右拖动照片</p>
              </div>
              <img src="image/bg1.png" alt="" class="img_top_left">
              <img src="image/bg2.png" alt="" class="img_btm_right">
              <img src="image/bg3.png" alt="" class="img_top_right">
              <img src="image/bg4.png" alt="" class="img_btm_left">
            </div>
    
            <!-- <div class="tips showTips" style="display:none;">
              <span class="border-1px">裁剪区域</span>
            </div> -->
          </div>
          <div class="preview">
            <img src="" alt="" id="preview" class="img-respone">
            <!-- <div class="tips">
              <span class="border-1px">预览区域</span>
            </div> -->
          </div>
        </section>
        <section class="wrapper_padding" id="apent">
          <button type="button" name="button" class="btn btn-primary btn-block" id="getFile" style="margin-bottom: 25px;">点击拍照</button>
          <button type="button" name="button" disabled class="btn btn-primary btn-block m-b" id="getImg">裁剪上传</button>
          <!--
        <button type="button" name="button" disabled class="btn btn-success btn-block m-b" id="upload">上传</button>
        -->
          <input type="file" id="file" accept="image/*" capture="camera">
        </section>
        <!-- 蒙层 -->
        <div id="mask" style="display:none;">
          <div class="runTime">
            <svg xmlns="http://www.w3.org/200/svg" height="100" width="100">
                <circle class="round" id="stroke_r" cx="50" cy="50" r="45" fill="none" stroke="#1ab394" stroke-width="8" stroke-dasharray="0,10000"/>
            </svg>
            <div class="runTime2">
              <svg xmlns="http://www.w3.org/200/svg" height="100" width="100">
                  <circle class="round" cx="50" cy="50" r="45" fill="none" stroke="#ccc" stroke-width="8" stroke-dasharray="10000,10000"/>
              </svg>
            </div>
            <div class="num" id="wait">20</div>
            <span class="text">请稍后</span>
          </div>
        </div>
    
      </form>
    </div>
  <script src="${ctx}/pub/de-js/jquery.min.js?v2.1.4"></script>
  <script src="${ctx}/pub/de-js/bootstrap.min.js"></script>
  <script src="${ctx}/pub/de-js/cropper.js"></script>
  <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
      var preview = document.getElementById('preview');
      var oImage = document.getElementById('image');
      var getFile = document.getElementById('getFile');
      var oFile = document.getElementById('file');
      //var oUpload = document.getElementById('upload');
      var getImg = document.getElementById('getImg');
      var getImg = document.getElementById('getImg');

      var cropper;

      // 点击打开相机
      getFile.onclick = function() {
        oFile.click();
        cropper.destroy();
        cropper = null;
      };
      // 拍完照初始化裁剪
      oFile.addEventListener('change', function(e) {
        $(".crop").show();
        $(".showTips").show();
        $(".preview").hide();
        $(".tips_text").hide();
        $("#getFile").text('重新拍照');
        var files = e.target.files;
        var done = function(url) {
          oFile.value = '';
          oImage.src = url;
        };
        var reader;
        var file;
        var url;

        if (files && files.length > 0) {
          file = files[0];
          if (URL) {
            done(URL.createObjectURL(file));
          } else if (FileReader) {
            reader = new FileReader();
            reader.onload = function(e) {
              done(reader.result);
            };
            reader.readAsDataURL(file);
          }
          cropper = new Cropper(oImage, {
            aspectRatio: NaN,
            viewMode: 3,
            dragMode: 'move',
            cropBoxMovable: true,
          });
          $("#getImg").removeAttr('disabled');
        }

      });
      // 抽出裁剪内容
      function getInfo() {
        var canvas;
        if (cropper) {
          canvas = cropper.getCroppedCanvas({
            width: 640,
            height: 480,
          });
          // 文件位置路径
          return imgVal = canvas.toDataURL("image/jpeg", 1);
        }
      };
      // 裁剪赋值预览
      getImg.addEventListener('click', function() {
        getInfo();
        preview.src = imgVal;
        $(".crop").hide();
        $(".preview").show();
        //$("#upload").removeAttr('disabled');
        $("#getImg").attr('disabled', 'disabled');
        //console.log(imgVal);
        //上传图片
        toUpload(imgVal);

      });
      //上传方法
      function toUpload(imgVal) {
        //AJax上传照片
        var guid = $('#personGuid').val();
        $.ajax({
          type: "POST", //用POST方式传输
          dataType: "JSON", //数据格式:JSON
          url: '${ctx}/register/camera.html', //目标地址
          data: {
            "base64": imgVal,
            "guid": guid
          },
          error: function(XMLHttpRequest, textStatus, errorThrown) {},
          success: function(data) {
            if (data.success) {
              //成功后，等待20S再调整下一页面
              $("#mask").show();
              $('#photeGuid').val(data.name); //photoGuid
              var stroke_r = document.getElementById("stroke_r");
              var circleLength = Math.floor(2 * Math.PI * stroke_r.getAttribute("r"));
              var num = 0;
              var wait = document.getElementById("wait");

              var temer = setInterval(function() {
                wait.innerHTML--;
                num++;
                var runMun = 5 * num;
                var val = parseFloat(runMun).toFixed(2);
                val = Math.max(0, val);
                val = Math.min(100, val);
                stroke_r.setAttribute("stroke-dasharray", "" + circleLength * val / 100 + ",10000");

                if (wait.innerHTML <= 0) {
                  wait.innerHTML = 0;
                  clearInterval(temer);
                  //成功后，跳转到二维码页面
                  $('#form-apply').attr('action', '${ctx}/register/returnResult.html');
                  $('#form-apply').submit();
                }
              }, 1000);

            } else { //失败
              alert("上传失败");
            }
          }
        });
      }
    });
  </script>
	</body>
	</html>