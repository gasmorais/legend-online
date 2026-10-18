package shadowland
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.shadowland.ShadowLandChapterInfo;
   import mvc.module.shadowland.ShadowLandModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.datas.templates.ShadowLandTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.ShadowLandManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class ShadowLandFightFrame extends Frame
   {
      
      private var _border:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _rewardBmp:Bitmap;
      
      private var _dropBmp:Bitmap;
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _fightBtn:IconButton;
      
      private var _mopupBtn:IconButton;
      
      private var _rewardHBox:HBox;
      
      private var _dropHBox:HBox;
      
      private var _tempInfo:ShadowLandTempInfo;
      
      public function ShadowLandFightFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("shadowLandFightFrame.border");
         _bg = ComponentFactory.Instance.creatBitmap("asset.ShadowLandFightFrame.bg");
         _rewardBmp = ComponentFactory.Instance.creatBitmap("asset.ShadowLandFightFrame.reward");
         _dropBmp = ComponentFactory.Instance.creatBitmap("asset.ShadowLandFightFrame.drop");
         _icon = ComponentFactory.Instance.creatBitmap("asset.ShadowLandFrame.icon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("shadowLandFightFrame.txt");
         _fightBtn = ComponentFactory.Instance.creatComponentByStylename("shadowLandFightFrame.fightBtn");
         _mopupBtn = ComponentFactory.Instance.creatComponentByStylename("shadowLandFightFrame.mopupBtn");
         _rewardHBox = ComponentFactory.Instance.creatCustomObject("shadowLandFightFrame.rewardHBox");
         _dropHBox = ComponentFactory.Instance.creatCustomObject("shadowLandFightFrame.dropHBox");
         addToContent(_border);
         addToContent(_bg);
         addToContent(_rewardBmp);
         addToContent(_dropBmp);
         addToContent(_rewardHBox);
         addToContent(_dropHBox);
         addToContent(_icon);
         addToContent(_txt);
         addToContent(_fightBtn);
         addToContent(_mopupBtn);
         _icon.x = 100;
         _icon.y = 195;
      }
      
      private function initRewardDrop() : void
      {
         var _loc3_:* = null;
         var _loc4_:GoodsInfo = null;
         var _loc1_:BaseItemView = null;
         var _loc2_:Array = TempleteManager.instance.shadowLandFightDropTempCate.getTemplatesByAreaDiffNode(_tempInfo.AreaId,_tempInfo.Difficulty,_tempInfo.NodeId);
         _rewardHBox.beginChanges();
         _dropHBox.beginChanges();
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc3_.itemId;
            _loc4_.count = _loc3_.count;
            _loc1_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _loc1_.data = _loc4_;
            if(_loc3_.appearType == 1)
            {
               _rewardHBox.addChild(_loc1_);
            }
            else
            {
               _dropHBox.addChild(_loc1_);
            }
         }
         _rewardHBox.commitChanges();
         _dropHBox.commitChanges();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _fightBtn.addEventListener("click",__fightBtnClickHandler);
         _mopupBtn.addEventListener("click",__mopupBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _fightBtn.removeEventListener("click",__fightBtnClickHandler);
         _mopupBtn.removeEventListener("click",__mopupBtnClickHandler);
      }
      
      private function __fightBtnClickHandler(param1:MouseEvent) : void
      {
         ShadowLandManager.instance.sendFight(_tempInfo.CheckpointId);
      }
      
      private function __mopupBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("mopup",19,_tempInfo);
      }
      
      private function refreshView() : void
      {
         if(!_tempInfo)
         {
            return;
         }
         titleText = LanguageMgr.GetTranslation("ShadowLandFightFrame.titleText" + _tempInfo.Difficulty,_tempInfo.AreaId,_tempInfo.NodeId);
         _txt.text = model.consume.toString();
         _mopupBtn.enable = false;
         var _loc1_:ShadowLandChapterInfo = model.getChapterInfoByAreaIdDiff(_tempInfo.AreaId,_tempInfo.Difficulty);
         if(_loc1_ && _loc1_.passNodeId >= _tempInfo.NodeId)
         {
            _mopupBtn.enable = true;
         }
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(param1 && param1.frameData)
         {
            _tempInfo = param1.frameData as ShadowLandTempInfo;
            initRewardDrop();
         }
         refreshView();
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
         ObjectUtils.disposeObject(_rewardBmp);
         _rewardBmp = null;
         ObjectUtils.disposeObject(_dropBmp);
         _dropBmp = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_fightBtn);
         _fightBtn = null;
         ObjectUtils.disposeObject(_mopupBtn);
         _mopupBtn = null;
         ObjectUtils.disposeAllChildren(_rewardHBox);
         _rewardHBox = null;
         ObjectUtils.disposeAllChildren(_dropHBox);
         _dropHBox = null;
         super.dispose();
      }
   }
}

