package doctor
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import doctor.view.LoaderInfoItem;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.system.System;
   import flash.text.TextField;
   import manager.ExternalInterfaceManager;
   
   public class DoctorFrame extends Frame
   {
      
      MutipleImage;
      ScaleFrameImage;
      Scale9CornerImage;
      
      private var _minBtn:BaseButton;
      
      private var _back1:ScaleBitmapImage;
      
      private var _back2:ScaleBitmapImage;
      
      private var _startDocBtn:IconButton;
      
      private var _copyBtn:IconButton;
      
      private var _decTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _itemList:Array;
      
      private var _copyText:TextField;
      
      private var _resuleTxt:String = "";
      
      public function DoctorFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("doctor.Back1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("doctor.Back2");
         _startDocBtn = ComponentFactory.Instance.creatComponentByStylename("doctor.StartBtn");
         _copyBtn = ComponentFactory.Instance.creatComponentByStylename("doctor.CopyBtn");
         _decTxt = ComponentFactory.Instance.creatComponentByStylename("doctor.Describetxt");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("doctor.Vbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("doctor.ScrollPanel");
         _minBtn = ComponentFactory.Instance.creatComponentByStylename("doctor.MinBtn");
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_startDocBtn);
         addToContent(_copyBtn);
         addToContent(_decTxt);
         addToContent(_scrollPanel);
         addToContent(_minBtn);
         _scrollPanel.setView(_vbox);
         _scrollPanel.vUnitIncrement = 58;
         _copyText = new TextField();
         _copyText.multiline = true;
         _decTxt.htmlText = "<font color=\'#36ff00\'>Clique em </font><font color=\'#ffcd63\'>Iniciar Diagnóstico</font><font color=\'#36ff00\'> para iniciar diagnóstico de carregamento.</font>";
         _startDocBtn.enable = false;
         _copyBtn.visible = false;
         titleText = "Diagnóstico do Legend Online";
      }
      
      private function initEvent() : void
      {
         _minBtn.addEventListener("click",__minHandler);
         _startDocBtn.addEventListener("click",__clickHandler);
         _copyBtn.addEventListener("click",__clickHandler);
         addEventListener("response",__frameResponseHandler);
         addEventListener("addedToStage",__addToStageHandler);
      }
      
      private function removeEvent() : void
      {
         _minBtn.removeEventListener("click",__minHandler);
         _startDocBtn.removeEventListener("click",__clickHandler);
         _copyBtn.removeEventListener("click",__clickHandler);
         removeEventListener("response",__frameResponseHandler);
         removeEventListener("addedToStage",__addToStageHandler);
      }
      
      private function __minHandler(param1:Event) : void
      {
         dispatchEvent(new Event("min",false,false));
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         removeEventListener("addedToStage",__addToStageHandler);
         Security.loadPolicyFile(ComponentSetting.RESOURCE_PATH + "crossdomain.xml");
         getSystemType();
         getBrowerType();
         tryCrossDomain();
         refreshLoaderList();
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _startDocBtn)
         {
            _startDocBtn.visible = false;
            _copyBtn.enable = false;
            _copyBtn.visible = true;
            startCheck();
         }
         else
         {
            copyResule();
         }
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function startCheck() : void
      {
         loadNext();
      }
      
      private function getSystemType() : void
      {
         var _loc2_:String = Capabilities.os;
         var _loc1_:String = Capabilities.version;
         var _loc3_:String = Capabilities.playerType;
         _resuleTxt += "Sistema: " + _loc2_ + ".<br>Versão do FlashPlayer:  " + _loc1_ + ".<br>Tipo do FlashPlayer: " + _loc3_ + ".<br>";
      }
      
      private function getBrowerType() : void
      {
         var _loc1_:String = null;
         try
         {
            _loc1_ = ExternalInterfaceManager.instance.getBrowerType();
            if(_loc1_)
            {
               _resuleTxt += "Informações do Navegador: " + _loc1_ + ".<br>";
            }
            else
            {
               _resuleTxt += "Informações do Navegador: Outros.<br>";
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function tryCrossDomain() : void
      {
         var _loc1_:URLLoader = new URLLoader();
         _loc1_.addEventListener("ioError",connectCrossDomainIOError);
         _loc1_.addEventListener("init",connectCrossDomainProgress);
         _loc1_.addEventListener("securityError",connectCrossDomainSecurityError);
         _loc1_.load(new URLRequest(ComponentSetting.RESOURCE_PATH + "crossdomain.xml"));
      }
      
      private function connectCrossDomainIOError(param1:IOErrorEvent) : void
      {
         _resuleTxt += "Lendo " + ComponentSetting.RESOURCE_PATH + "crossdomain.xml erro IO;<br>";
      }
      
      private function connectCrossDomainProgress(param1:Event) : void
      {
         _resuleTxt += "Lendo " + ComponentSetting.RESOURCE_PATH + "Sucedido.<br>";
      }
      
      private function connectCrossDomainSecurityError(param1:SecurityErrorEvent) : void
      {
         _resuleTxt += "Lendo erro de sandbox crossdomain.xml.<br>";
         _decTxt.htmlText = "<font color=\'#FF0000\'>Lendo erro sandbox crossdomain.xml</font>";
      }
      
      private function refreshLoaderList() : void
      {
         var _loc2_:String = null;
         var _loc1_:LoaderInfoItem = null;
         var _loc4_:int = 1;
         _itemList = [];
         for(var _loc3_:String in ComponentSetting.checkMD5)
         {
            _loc2_ = ComponentSetting.getMD5FileNameByFilePath(_loc3_);
            _loc1_ = new LoaderInfoItem(_loc4_ + " . " + _loc2_,_loc3_);
            _vbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc4_++;
         }
         _scrollPanel.invalidateViewport();
         _startDocBtn.enable = true;
      }
      
      private function loadNext() : void
      {
         var _loc1_:LoaderInfoItem = null;
         if(_itemList.length > 0)
         {
            _loc1_ = _itemList.shift();
            _loc1_.start(checkComplete);
            if(_loc1_.y > _loc1_.viewRectangle.height * 10)
            {
               _scrollPanel.vScrollbar.scrollValue = _loc1_.y - _loc1_.viewRectangle.height * 9;
            }
         }
         else
         {
            _copyBtn.enable = true;
            _decTxt.y -= 5;
            _decTxt.htmlText = "Verificação dos documentos concluída, caso tenha aviso de erro, copie, salve e envie ao nosso SAC. <br>Caso verificação seja concluída, limpe cache do navegador e entre no jogo novamente.";
         }
      }
      
      private function checkComplete(param1:String) : void
      {
         _resuleTxt += "Arquivo" + param1 + ".<br>";
         loadNext();
      }
      
      private function copyResule() : void
      {
         _copyText.htmlText = _resuleTxt;
         System.setClipboard(_copyText.text);
         _decTxt.text = "Copiado com sucesso";
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         for each(var _loc1_:LoaderInfoItem in _itemList)
         {
            _loc1_.stop();
            ObjectUtils.disposeObject(_loc1_);
         }
         ObjectUtils.disposeObject(_back1);
         ObjectUtils.disposeObject(_back2);
         ObjectUtils.disposeObject(_startDocBtn);
         ObjectUtils.disposeObject(_decTxt);
         ObjectUtils.disposeObject(_copyBtn);
         ObjectUtils.disposeObject(_copyText);
         _back1 = null;
         _back2 = null;
         _startDocBtn = null;
         _copyBtn = null;
         _decTxt = null;
         _itemList = null;
         _copyText = null;
         _resuleTxt = null;
         super.dispose();
      }
   }
}

