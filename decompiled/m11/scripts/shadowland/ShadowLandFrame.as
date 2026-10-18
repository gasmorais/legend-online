package shadowland
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.shadowland.ShadowLandModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.ShadowLandManager;
   import yishi.utils.MsgMan;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ShadowLandFrame extends Frame
   {
      
      private var _border:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _mapCon:Component;
      
      private var _mapList:Vector.<ShadowLandMapItem>;
      
      private var nodePosAry:Array = [[99,13],[36,285],[436,178],[394,-2],[685,70]];
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      public function ShadowLandFrame()
      {
         super();
         initView();
         initMapView();
         addEvent();
         ShadowLandManager.instance.sendDataRequest();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ShadowLandFrame.titleText");
         _border = ComponentFactory.Instance.creatComponentByStylename("shadowLandFrame.border");
         _bg = ComponentFactory.Instance.creatBitmap("asset.ShadowLandFrame.bg");
         _mapCon = ComponentFactory.Instance.creatComponentByStylename("shadowLandFrame.mapCon");
         _icon = ComponentFactory.Instance.creatBitmap("asset.ShadowLandFrame.icon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("shadowLandFrame.txt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("shadowLandFrame.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("ShadowLandFrame.helperFrame.HelpTitle.text");
         addToContent(_border);
         addToContent(_bg);
         addToContent(_mapCon);
         addToContent(_icon);
         addToContent(_txt);
         addToContent(_helpBtn);
      }
      
      private function initMapView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ShadowLandMapItem = null;
         _mapList = new Vector.<ShadowLandMapItem>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new ShadowLandMapItem(_loc2_ + 1);
            _loc1_.x = nodePosAry[_loc2_][0];
            _loc1_.y = nodePosAry[_loc2_][1];
            _mapList.push(_loc1_);
            _mapCon.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         MsgMan.addObserver("SHADOWLAND_INFO_UPDATE",this,__updateInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("SHADOWLAND_INFO_UPDATE",this,__updateInfoHandler);
         _helpBtn.removeEventListener("click",__helpBtnHandler);
      }
      
      private function __updateInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("ShadowLandFrame.helperFrame");
         _loc2_.show();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _mapList.length)
         {
            _mapList[_loc1_].data = _loc1_ < model.areaInfoDic.getList().length ? model.areaInfoDic.getList()[_loc1_] : null;
            _loc1_++;
         }
         _txt.text = LanguageMgr.GetTranslation("fish.FishFrame.countText",model.curNum,model.maxNum);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : ShadowLandModel
      {
         return ShadowLandManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_mapCon);
         _mapCon = null;
         ObjectUtils.disposeObject(_mapList);
         _mapList = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         super.dispose();
      }
   }
}

