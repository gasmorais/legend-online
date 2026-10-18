package yishi.view.frame
{
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.manager.BaseManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class UpdateBroadCastFrame extends Frame implements IManualSize
   {
      
      private var _back1:Scale9CornerImage;
      
      private var _back2:Image;
      
      private var _back3:ScaleLeftRightImage;
      
      private var _btn:IconButton;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _dateAsset:Bitmap;
      
      private var _updateDate:FilterFrameText;
      
      private var _updateContent:Bitmap;
      
      private var _updatePre:Bitmap;
      
      private var _titleSp1:Sprite;
      
      private var _titleSp2:Sprite;
      
      private var _itemArr1:Array;
      
      private var _itemArr2:Array;
      
      private var _updateTitleBg:Bitmap;
      
      private var _updatePreTitleBg:Bitmap;
      
      private var _contain:VBox;
      
      private var _callBack:Function;
      
      public function UpdateBroadCastFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,650,600);
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.UpdateBroadCastBack1");
         _back3 = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.UpdateBroadCastBack3");
         _btn = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.UpdateBroadCastBtn");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.UpdateBroadCastScroll");
         _updateDate = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.UpdateBroadCastDate");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("broadcast.UpdateBackAsset");
         _dateAsset = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateDateAsset");
         _updateTitleBg = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateTitleBg");
         _updateContent = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateContentAsset");
         _updatePre = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdatePreAsset");
         _updatePreTitleBg = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateTitleBg");
         _contain = new VBox();
         _contain.spacing = 10;
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_back3);
         addToContent(_btn);
         addToContent(_scrollPanel);
         titleText = LanguageMgr.GetTranslation("yishi.view.UpdateBroadCastFrame.title");
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
      
      override protected function addChildren() : void
      {
         super.addChildren();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _btn.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         if(_btn)
         {
            _btn.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         removeEvent();
         TweenMax.to(this,1,{
            "scaleX":0.01,
            "scaleY":0.01,
            "x":stage.stageWidth - 30,
            "y":40,
            "onComplete":tweenComplete
         });
         mouseEnabled = mouseChildren = false;
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               removeEvent();
               _changedPropeties = null;
               mouseEnabled = mouseChildren = false;
               TweenMax.to(this,1,{
                  "scaleX":0.01,
                  "scaleY":0.01,
                  "x":stage.stageWidth - 30,
                  "y":40,
                  "onComplete":tweenComplete
               });
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:String = null;
         var _loc4_:* = null;
         var _loc2_:Sprite = null;
         var _loc5_:FilterFrameText = null;
         var _loc3_:Sprite = null;
         var _loc10_:FilterFrameText = null;
         var _loc6_:XML = BaseManager.instance.updateBroadcastContent;
         if(!_loc6_)
         {
            return;
         }
         try
         {
            _updateDate.text = _loc6_..time[0].toString();
         }
         catch(e:Error)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.UpdateBroadCastFrame.Alert");
            MessageTipManager.instance().show(_loc1_);
            dispose();
            return;
         }
         var _loc7_:String = "";
         var _loc9_:String = "";
         var _loc8_:RegExp = /\/n/g;
         for each(_loc4_ in _loc6_.curContent..item)
         {
            if(_loc4_)
            {
               _loc2_ = new Sprite();
            }
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.UpdateBroadCastContent");
            if(!StringHelper.isNullOrEmpty(_loc4_.content.text()))
            {
               if(!StringHelper.isNullOrEmpty(_loc4_.title.text()))
               {
                  _loc7_ = "<font color=\'#f5e3b1\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
               }
               _loc7_ = _loc7_ + "<font color=\'#bf9048\'><textformat leading=\'7px\' blockIndent=\'13em\'>" + _loc4_.content.text() + "</textformat></font>\n";
            }
            else if(!StringHelper.isNullOrEmpty(_loc4_.title.text()))
            {
               _loc7_ = "<font color=\'#f5e3b1\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
            }
            _loc7_ = _loc7_.replace(_loc8_,"<br/>");
            _loc5_.htmlText = _loc7_;
            _loc5_.height = _loc5_.textHeight + 4;
            _loc2_.addChild(_loc5_);
            _itemArr1.push(_loc2_);
         }
         if(!StringHelper.isNullOrEmpty(_loc7_))
         {
            _contain.addChild(_titleSp1);
            for each(_loc2_ in _itemArr1)
            {
               _contain.addChild(_loc2_);
            }
         }
         for each(_loc4_ in _loc6_.nextContent..item)
         {
            if(_loc4_)
            {
               _loc3_ = new Sprite();
            }
            _loc10_ = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.UpdateBroadCastContent");
            if(!StringHelper.isNullOrEmpty(_loc4_.content.text()))
            {
               if(!StringHelper.isNullOrEmpty(_loc4_.title.text()))
               {
                  _loc9_ = "<font color=\'#f5e3b1\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
               }
               _loc9_ = _loc9_ + "<font color=\'#bf9048\'><textformat leading=\'7px\' blockIndent=\'13em\'>" + _loc4_.content.text() + "</textformat></font>\n";
            }
            else if(!StringHelper.isNullOrEmpty(_loc4_.title.text()))
            {
               _loc9_ = "<font color=\'#f5e3b1\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
            }
            _loc9_ = _loc9_.replace(_loc8_,"<br/>");
            _loc10_.htmlText = _loc9_;
            _loc10_.height = _loc10_.textHeight + 4;
            _loc3_.addChild(_loc10_);
            _itemArr2.push(_loc3_);
         }
         if(!StringHelper.isNullOrEmpty(_loc9_))
         {
            _contain.addChild(_titleSp2);
            for each(_loc3_ in _itemArr2)
            {
               _contain.addChild(_loc3_);
            }
         }
         _scrollPanel.invalidateViewport();
      }
      
      public function show(param1:Function = null) : void
      {
         _callBack = param1;
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         TweenMax.killTweensOf(this);
         removeEvent();
         if(_callBack != null)
         {
            _callBack();
         }
         _callBack = null;
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_back3);
         _back3 = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
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
      
      private function tweenComplete() : void
      {
         dispose();
      }
   }
}

