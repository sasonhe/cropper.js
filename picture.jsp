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
    <title>第十五届中国国际中小企业博览会智能家电展</title>
    <meta name="keywords" />
    <meta name="description" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="${ctx}/pub/de-css/cropper.css">
    <link rel="stylesheet" href="${ctx}/pub/de-css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/pub/de-css/ex_index.css">
  </head>
  <style>
    * {
	  margin: 0;
	  padding: 0;
	}
  </style>
  <body>
    <div class="mainBox">
      <form name="form-apply" id="form-apply">
        <input name="photeGuid" id="photeGuid" type="hidden" />
        <input type="hidden" value="${personGuid}" name="personGuid" id="personGuid" />
        <input type="hidden" value="10023" name="expoId" id="expoId" />
        <img src="" alt="" id="preview" class="img-respone" style="display:none;">
        <div class="fiexd">
          <div class="alert-wrapper">
            <span class="close-btn" id="close">&#215;</span>
            <div class="header">注意事项</div>
            <div class="body">
              <div class="ok">
                <dl>
                  <dt><img src="image/200.jpg" alt=""></dt>
                  <dd>正确案例</dd>
                </dl>
              </div>
              <div class="ng clearfix">
                <dl>
                  <dt><img src="image/1.jpg" alt=""></dt>
                  <dd>照片中不能有多人</dd>
                </dl>
                <dl>
                  <dt><img src="image/2.jpg" alt=""></dt>
                  <dd>照片人脸不能遮挡</dd>
                </dl>
                <dl>
                  <dt><img src="image/3.jpg" alt=""></dt>
                  <dd>照片不能模糊</dd>
                </dl>
              </div>
              <div class="ng clearfix">
                <dl>
                  <dt><img src="image/4.jpg" alt=""></dt>
                  <dd>人脸姿态端正</dd>
                </dl>
                <dl>
                  <dt><img src="image/5.jpg" alt=""></dt>
                  <dd>不能带墨镜</dd>
                </dl>
                <dl>
                  <dt><img src="image/6.jpg" alt=""></dt>
                  <dd>照片侧脸角度过大</dd>
                </dl>
              </div>
            </div>
            <div class="footer"><span id="getFile">点击拍照</span></div>
          </div>
        </div>
        <section>
          <div class="crop">
            <div class="person-wrapper">
              <div class="person"><img src="image/picbg.png" alt="" class="img-respone"></div>
              <div class="text">
                <p>体验人脸识别快速入场</p>
              </div>
            </div>
            <div><img src="" alt="" id="image" class="img-respone" style="opacity:0;"></div>
          </div>
        </section>
        <section class="wrapper_padding" id="apent">
          <button type="button" name="button" class="btn btn-primary btn-block" id="tipInfo">马上体验</button>

          <input type="file" id="file" accept="image/*" capture="camera">
        </section>
        <div id="btn-show" class="" style="display:none;background:#fff;">
          <div class="btn-item">
            <button type="button" name="button" class="btn btn-default btn-block" id="resetTips" style="color: #333;background-color: #fff;border-color: #ccc;">重新拍照</button>
          </div>
          <div class="btn-item">
            <button type="button" name="button" class="btn btn-primary btn-block" id="getImg">裁剪上传</button>
          </div>
        </div>
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
  <script src="${ctx}/pub/de-js/jquery-1.9.1.min.js"></script>
  <script src="${ctx}/pub/de-js/bootstrap.min.js"></script>
  <script src="${ctx}/pub/de-js/cropper.js"></script>
  <script type="text/javascript">
    $("#tipInfo").click(function() {
      $(".fiexd").show();
    });
    $("#resetTips").click(function() {
      $(".fiexd").show();
    });
    $("#close").click(function() {
      $(".fiexd").hide();
    });
    document.addEventListener('DOMContentLoaded', function() {
      var preview = document.getElementById('preview');
      var oImage = document.getElementById('image');
      var getFile = document.getElementById('getFile');
      var oFile = document.getElementById('file');
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
        var CH = document.body.clientHeight;
        var imgHeight = 420;
        if (CH <= 480) {
          imgHeight = 420
        } else {
          imgHeight = 500;
        };　
        $("#image").css({
          'height': imgHeight + 'px'
        });
        $(".crop").show();
        $(".fiexd").hide();
        $(".person-wrapper").hide();
        $("#btn-show").show();
        $("#apent").hide();
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
            viewMode: 0,
            dragMode: 'move',
            cropBoxMovable: true,
          });
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
        $("#preview").show();
        $("#getImg").attr('disabled', 'disabled');
        $("#resetTips").attr('disabled', 'disabled');
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
          url: '${ctx}/register/camera2.html', //目标地址
          data: {
            "base64": imgVal,
            "guid": guid
          },
          error: function(XMLHttpRequest, textStatus, errorThrown) {
            $("#getImg").attr('disabled', false);
            $("#resetTips").attr('disabled', false);
          },
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
              $("#getImg").attr('disabled', false);
              $("#resetTips").attr('disabled', false);
            }
          }
        });
      }
    });
  </script>
	</body>
	</html>
