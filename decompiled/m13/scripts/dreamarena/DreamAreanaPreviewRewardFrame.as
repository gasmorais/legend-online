package dreamarena
{
   import battle.utils.Helpers;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.item.DreamAreanaPreviewRewardItem;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.TempleteManager;
   
   public class DreamAreanaPreviewRewardFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _rewardPanel:ScrollPanel;
      
      private var _itemBox:VBox;
      
      public function DreamAreanaPreviewRewardFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,503,496);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.DreamAreanaPreviewRewardFrame.bg");
         _rewardPanel = ComponentFactory.Instance.creatComponentByStylename("DreamAreanaPreviewRewardFrame.rewardPanel");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("DreamAreanaPreviewRewardFrame.itemBox");
         addToContent(_bg);
         addToContent(_rewardPanel);
         _rewardPanel.setView(_itemBox);
      }
      
      public function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:DreamAreanaPreviewRewardItem = null;
         var _loc2_:Dictionary = TempleteManager.instance.dreamArenaRewardTempCate.getWinCountTemplatesDic();
         _itemBox.removeAllChild();
         var _loc3_:Array = Helpers.getKeyList(_loc2_);
         _loc4_ = _loc3_.length - 1;
         while(_loc4_ >= 0)
         {
            _loc1_ = new DreamAreanaPreviewRewardItem(_loc4_);
            _loc1_.setWinCount(_loc3_[_loc4_]);
            _loc1_.data = _loc2_[_loc3_[_loc4_]];
            _itemBox.addChild(_loc1_);
            _loc4_--;
         }
         _rewardPanel.beginChanges();
         _rewardPanel.invalidateViewport();
         _rewardPanel.commitChanges();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
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
         this.titleText = LanguageMgr.GetTranslation("DreamAreanaPreviewRewardFrame.titleText.text");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rewardPanel);
         _rewardPanel = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         super.dispose();
      }
   }
}

