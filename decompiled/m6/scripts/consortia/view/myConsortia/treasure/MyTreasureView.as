package consortia.view.myConsortia.treasure
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.net.ConsortiaSocektSendManager;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.MyTreasureInfo;
   import mvc.module.consortia.TreasureGroupInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.ConsortiaTreasureTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.NotificationManager;
   
   public class MyTreasureView extends Component
   {
      
      private var _TxtImg1:Bitmap;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _ItemArr:Array;
      
      public function MyTreasureView()
      {
         super();
         initView();
         initEvent();
         ConsortiaSocektSendManager.sendOpenTreasure(1);
      }
      
      private static function GoodsSortFuncDesc(param1:MyTreasureInfo, param2:MyTreasureInfo) : int
      {
         var _loc4_:ConsortiaTreasureTemplateInfo = null;
         var _loc3_:ConsortiaTreasureTemplateInfo = null;
         if(param1.status > param2.status)
         {
            return -1;
         }
         if(param1.status < param2.status)
         {
            return 1;
         }
         if(param1.requestHelpCount < param2.requestHelpCount)
         {
            return -1;
         }
         if(param1.requestHelpCount > param2.requestHelpCount)
         {
            return 1;
         }
         _loc4_ = ConsortiaManager.instance.getTreasureTempByID(param1.treasureTemplateId);
         _loc3_ = ConsortiaManager.instance.getTreasureTempByID(param2.treasureTemplateId);
         if(_loc4_.Quality > _loc3_.Quality)
         {
            return -1;
         }
         if(_loc4_.Quality < _loc3_.Quality)
         {
            return 1;
         }
         return 0;
      }
      
      private function initView() : void
      {
         _TxtImg1 = ComponentFactory.Instance.creatBitmap("asset.consortia.MyTreasureTxt1");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasure.Vbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("consortia.MyTreasurePanel");
         _scrollPanel.setView(_vbox);
         _ItemArr = [];
         addChild(_TxtImg1);
         addChild(_scrollPanel);
      }
      
      private function __updataMyHandler(param1:ConsortiaEvent) : void
      {
         var _loc3_:MyTreasureItem = null;
         var _loc2_:int = 0;
         clearVox();
         model.treasureGroupInfo.myTreasures.sort(GoodsSortFuncDesc);
         _loc2_ = 0;
         while(_loc2_ < model.treasureGroupInfo.myTreasures.length)
         {
            _loc3_ = new MyTreasureItem();
            _loc3_.data = treasureGroupInfo.myTreasures[_loc2_];
            _vbox.addChild(_loc3_);
            _ItemArr.push(_loc3_);
            _loc2_++;
         }
         _vbox.refreshChildPos();
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      private function __removeItemHandle(param1:NotificationEvent) : void
      {
         ConsortiaSocektSendManager.sendOpenTreasure(1);
      }
      
      private function __openHandler(param1:ConsortiaEvent) : void
      {
         ConsortiaSocektSendManager.sendOpenTreasure(1);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("MYTREASURE_REMOVE",__removeItemHandle);
         ConsortiaManager.instance.model.addEventListener("OPEN_MY_TREASURES",__updataMyHandler);
         ConsortiaManager.instance.model.addEventListener("GET_REWARD",__openHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("MYTREASURE_REMOVE",__removeItemHandle);
         ConsortiaManager.instance.model.removeEventListener("OPEN_MY_TREASURES",__updataMyHandler);
         ConsortiaManager.instance.model.removeEventListener("GET_REWARD",__openHandler);
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get treasureGroupInfo() : TreasureGroupInfo
      {
         return ConsortiaManager.instance.model.treasureGroupInfo;
      }
      
      private function clearVox() : void
      {
         var _loc1_:MyTreasureItem = null;
         var _loc2_:int = 0;
         if(_ItemArr.length == 0)
         {
            return;
         }
         _loc2_ = _ItemArr.length - 1;
         while(_loc2_ >= 0)
         {
            if(_ItemArr[_loc2_])
            {
               _ItemArr[_loc2_].dispose();
               _ItemArr[_loc2_] = null;
            }
            _ItemArr.pop();
            _loc2_--;
         }
         _loc1_ = null;
         _vbox.removeAllChild();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_TxtImg1)
         {
            ObjectUtils.disposeObject(_TxtImg1);
         }
         _TxtImg1 = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
         LogicUtils.disposeDisplayCollection(_ItemArr);
         _ItemArr = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

