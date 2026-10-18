package notice
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   
   public class NoticeFrame extends Frame implements IManualSize
   {
      
      private var _back:MovieClip;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _content:Component;
      
      private var _updateTitleBg:Bitmap;
      
      private var _updateContent:Bitmap;
      
      private var _dateAsset:Bitmap;
      
      private var _updateDate:FilterFrameText;
      
      private var _updatePreTitleBg:Bitmap;
      
      private var _updatePre:Bitmap;
      
      private var _titleSp1:Sprite;
      
      private var _titleSp2:Sprite;
      
      private var _contain:VBox;
      
      private var _itemArr1:Array;
      
      private var _itemArr2:Array;
      
      private var _loader:URLLoader;
      
      private var xml:XML;
      
      public function NoticeFrame()
      {
         super();
      }
      
      public function load() : void
      {
         if(!_loader)
         {
            _loader = new URLLoader();
         }
         _loader.dataFormat = "text";
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["rnd"] = Math.random();
         var _loc2_:URLRequest = new URLRequest(ComponentSetting.VERTION_PATH);
         _loc2_.data = _loc1_;
         _loader.addEventListener("complete",__completehandler);
         _loader.load(_loc2_);
      }
      
      private function __completehandler(param1:Event) : void
      {
         if(isDie)
         {
            return;
         }
         xml = XML((param1.currentTarget as URLLoader).data);
         param1.currentTarget.removeEventListener("complete",__completehandler);
         initView();
         refreshView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = "Anúncio de Atualização";
         _back = ComponentFactory.Instance.creatCustomObject("noticeFrame.UpdateBroadCastBack");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("noticeFrame.UpdateBroadCastScroll");
         _updateDate = ComponentFactory.Instance.creatComponentByStylename("noticeFrame.UpdateBroadCastDate");
         _dateAsset = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateDateAsset");
         _updateTitleBg = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateTitleBg");
         _updateContent = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateContentAsset");
         _updatePre = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdatePreAsset");
         _updatePreTitleBg = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateTitleBg");
         _contain = new VBox();
         _contain.spacing = 10;
         addToContent(_back);
         addToContent(_scrollPanel);
         _titleSp1 = new Sprite();
         _titleSp2 = new Sprite();
         _itemArr1 = [];
         _itemArr2 = [];
         _titleSp1.addChild(_updateTitleBg);
         _titleSp1.addChild(_updateContent);
         _titleSp1.addChild(_dateAsset);
         _titleSp1.addChild(_updateDate);
         _titleSp2.addChild(_updatePreTitleBg);
         _titleSp2.addChild(_updatePre);
         _scrollPanel.setView(_contain);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         if(_loader)
         {
            _loader.removeEventListener("complete",__completehandler);
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
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,635,407);
      }
      
      private function refreshView() : void
      {
         var _loc1_:String = null;
         var _loc4_:* = null;
         var _loc2_:Sprite = null;
         var _loc5_:FilterFrameText = null;
         var _loc3_:Sprite = null;
         var _loc9_:FilterFrameText = null;
         if(!xml)
         {
            return;
         }
         try
         {
            _updateDate.text = xml..time[0].toString();
         }
         catch(e:Error)
         {
            _loc1_ = "Não há comunicado de atualização";
            dispose();
            return;
         }
         var _loc6_:String = "";
         var _loc8_:String = "";
         var _loc7_:RegExp = /\/n/g;
         for each(_loc4_ in xml.curContent..item)
         {
            if(_loc4_)
            {
               _loc2_ = new Sprite();
            }
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("timestory.UpdateBroadCastContent");
            if(!isNullOrEmpty(_loc4_.content.text()))
            {
               if(!isNullOrEmpty(_loc4_.title.text()))
               {
                  _loc6_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
               }
               _loc6_ = _loc6_ + "<font color=\'#e4d9ba\'><textformat leading=\'7px\' blockIndent=\'13em\'>" + _loc4_.content.text() + "</textformat></font>\n";
            }
            else if(!isNullOrEmpty(_loc4_.title.text()))
            {
               _loc6_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
            }
            _loc6_ = _loc6_.replace(_loc7_,"<br/>");
            _loc5_.htmlText = _loc6_;
            _loc5_.height = _loc5_.textHeight + 4;
            _loc2_.addChild(_loc5_);
            _itemArr1.push(_loc2_);
         }
         if(!isNullOrEmpty(_loc6_))
         {
            _contain.addChild(_titleSp1);
            for each(_loc2_ in _itemArr1)
            {
               _contain.addChild(_loc2_);
            }
         }
         for each(_loc4_ in xml.nextContent..item)
         {
            if(_loc4_)
            {
               _loc3_ = new Sprite();
            }
            _loc9_ = ComponentFactory.Instance.creatComponentByStylename("timestory.UpdateBroadCastContent");
            if(!isNullOrEmpty(_loc4_.content.text()))
            {
               if(!isNullOrEmpty(_loc4_.title.text()))
               {
                  _loc8_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
               }
               _loc8_ = _loc8_ + "<font color=\'#e4d9ba\'><textformat leading=\'7px\' blockIndent=\'13em\'>" + _loc4_.content.text() + "</textformat></font>\n";
            }
            else if(!isNullOrEmpty(_loc4_.title.text()))
            {
               _loc8_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
            }
            _loc8_ = _loc8_.replace(_loc7_,"<br/>");
            _loc9_.htmlText = _loc8_;
            _loc9_.height = _loc9_.textHeight + 4;
            _loc3_.addChild(_loc9_);
            _itemArr2.push(_loc3_);
         }
         if(!isNullOrEmpty(_loc8_))
         {
            _contain.addChild(_titleSp2);
            for each(_loc3_ in _itemArr2)
            {
               _contain.addChild(_loc3_);
            }
         }
         _scrollPanel.invalidateViewport();
      }
      
      public function isNullOrEmpty(param1:String) : Boolean
      {
         return param1 == null || param1 == "";
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_dateAsset);
         _dateAsset = null;
         ObjectUtils.disposeObject(_updateDate);
         _updateDate = null;
         ObjectUtils.disposeObject(_updateContent);
         _updateContent = null;
         ObjectUtils.disposeObject(_updatePre);
         _updatePre = null;
         ObjectUtils.disposeObject(_titleSp1);
         _titleSp1 = null;
         ObjectUtils.disposeObject(_titleSp2);
         _titleSp2 = null;
         ObjectUtils.disposeObject(_itemArr1);
         _itemArr1 = null;
         ObjectUtils.disposeObject(_itemArr2);
         _itemArr2 = null;
         super.dispose();
      }
   }
}

