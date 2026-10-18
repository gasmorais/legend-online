package goldensheep
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import events.GoldenSheepEvent;
   import flash.geom.Rectangle;
   import mvc.module.goldensheep.GoldenSheepModel;
   import mvc.module.goldensheep.GoldenSheepRecordInfo;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoldenSheepManager;
   import yishi.view.community.BaseItemView;
   
   public class GoldenSheepFrame extends Frame implements IManualSize
   {
      
      private var _rewardItemBg:Image;
      
      private var _rewardItemView:BaseItemView;
      
      private var _rewardTipTxt:Image;
      
      private var _noRewardTipTxt:Image;
      
      private var _itemList:Vector.<GoldenSheepItemView>;
      
      private var _vBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _model:GoldenSheepModel = GoldenSheepManager.instance.model;
      
      public function GoldenSheepFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,447,735);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _rewardItemBg = ComponentFactory.Instance.creatComponentByStylename("goldensheep.GoldenSheepFrame.rewardItemBg");
         _rewardItemView = ComponentFactory.Instance.creatCustomObject("goldensheep.GoldenSheepFrame.rewardItemView");
         _rewardTipTxt = ComponentFactory.Instance.creatComponentByStylename("goldensheep.GoldenSheepFrame.rewardTipTxt");
         _noRewardTipTxt = ComponentFactory.Instance.creatComponentByStylename("goldensheep.GoldenSheepFrame.noRewardTipTxt");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("goldensheep.GoldenSheepFrame.vBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("goldensheep.GoldenSheepFrame.scrollPanel");
         _scrollPanel.setView(_vBox,true);
         _rewardItemBg.visible = false;
         _rewardItemView.visible = false;
         _rewardTipTxt.visible = false;
         _noRewardTipTxt.visible = false;
         addToContent(_rewardItemBg);
         addToContent(_rewardItemView);
         addToContent(_rewardTipTxt);
         addToContent(_noRewardTipTxt);
         addToContent(_scrollPanel);
      }
      
      private function uninitView() : void
      {
         if(_vBox)
         {
            _vBox.disposeAllChildren();
         }
         ObjectUtils.disposeObject(_rewardItemBg);
         _rewardItemBg = null;
         ObjectUtils.disposeObject(_rewardItemView);
         _rewardItemView = null;
         ObjectUtils.disposeObject(_rewardTipTxt);
         _rewardTipTxt = null;
         ObjectUtils.disposeObject(_noRewardTipTxt);
         _noRewardTipTxt = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _model.addEventListener("STATE_UPDATE",__stateUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _model.removeEventListener("STATE_UPDATE",__stateUpdateHandler);
      }
      
      private function __stateUpdateHandler(param1:GoldenSheepEvent) : void
      {
         if(!_model.needShow)
         {
            dispose();
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
      
      private function refreshView() : void
      {
         var _loc1_:GoldenSheepItemView = null;
         var _loc5_:GoldenSheepRecordInfo = null;
         var _loc4_:int = 0;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = _model.rewardId;
         _loc3_.count = _model.myCount;
         _rewardItemView.data = _loc3_;
         if(_model.myCount > 0)
         {
            _rewardItemBg.visible = true;
            _rewardItemView.visible = true;
            _rewardTipTxt.visible = true;
            _noRewardTipTxt.visible = false;
         }
         else
         {
            _rewardItemBg.visible = false;
            _rewardItemView.visible = false;
            _rewardTipTxt.visible = false;
            _noRewardTipTxt.visible = true;
         }
         ObjectUtils.disposeAllChildren(_vBox);
         _scrollPanel.beginChanges();
         var _loc2_:int = int(_model.recordList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = _model.recordList[_loc4_];
            _loc1_ = new GoldenSheepItemView();
            _loc1_.data = _loc5_;
            _vBox.addChild(_loc1_);
            _loc4_++;
         }
         _vBox.refreshChildPos();
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

