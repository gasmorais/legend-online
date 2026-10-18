package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.internals.data.CampaignNode;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SkyStepView extends Sprite implements Disposeable
   {
      
      private static const NUM:int = 7;
      
      private var _bg:ScaleBitmapImage;
      
      private var _back:MutipleImage;
      
      private var _helpBtn:BaseButton;
      
      private var _mapBtn:IconButton;
      
      private var _vBox:VBox;
      
      private var _itemList:SimpleDictionary;
      
      public function SkyStepView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("skyStepView.bg");
         _back = ComponentFactory.Instance.creatComponentByStylename("skyStepView.back");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("skyStepView.helpBtn");
         _mapBtn = ComponentFactory.Instance.creatComponentByStylename("skyStepView.mapBtn");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("skyStepView.VBox");
         addChild(_bg);
         addChild(_back);
         addChild(_mapBtn);
         addChild(_vBox);
         initItem();
         addChild(_helpBtn);
      }
      
      private function initEvent() : void
      {
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         _mapBtn.addEventListener("click",__mapBtnClickHandler);
         model.addEventListener("UPDATE_CAMPAING_NODE",__updateNodeHandler);
      }
      
      private function removeEvent() : void
      {
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         _mapBtn.removeEventListener("click",__mapBtnClickHandler);
         model.removeEventListener("UPDATE_CAMPAING_NODE",__updateNodeHandler);
      }
      
      private function __updateNodeHandler(param1:* = null) : void
      {
         refreshView();
      }
      
      private function __mapBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("skystep");
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("skyStepView.helpFrame");
         _loc2_.show();
      }
      
      private function refreshView() : void
      {
         var _loc2_:SkyStepItem = null;
         var _loc1_:Array = model.mapNodesData;
         _loc1_.sort(sortFun);
         for each(var _loc3_:CampaignNode in _loc1_)
         {
            if(_itemList[_loc3_.nodeId])
            {
               _loc2_ = _itemList[_loc3_.nodeId];
               _loc2_.refreshView(_loc3_);
            }
         }
      }
      
      private function initItem() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:SkyStepItem = null;
         _itemList = new SimpleDictionary();
         var _loc1_:Array = model.mapNodesData;
         _loc1_.sort(sortFun);
         var _loc5_:int = 0;
         for each(var _loc6_:CampaignNode in _loc1_)
         {
            if(_loc6_.info.types == 42 && _loc5_ < 7)
            {
               _loc2_ = new SkyStepItem(_loc5_);
               _vBox.addChild(_loc2_);
               _itemList.add(_loc6_.nodeId,_loc2_);
               _loc2_.refreshView(_loc6_);
               _loc5_++;
            }
         }
      }
      
      private function sortFun(param1:CampaignNode, param2:CampaignNode) : Number
      {
         if(param1.nodeId < param2.nodeId)
         {
            return -1;
         }
         if(param1.nodeId > param2.nodeId)
         {
            return 1;
         }
         return 0;
      }
      
      private function get model() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_mapBtn);
         _mapBtn = null;
         ObjectUtils.disposeAllChildren(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

