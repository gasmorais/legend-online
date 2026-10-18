package raveparty.sort
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.RavePartyManager;
   import mvc.module.raveparty.RavePartyModel;
   import mvc.module.raveparty.RavePartyRewardInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class RavePartySortRewardFrame extends Frame
   {
      
      private var alertText:FilterFrameText;
      
      private var vBox:VBox;
      
      private var _rewardType:int;
      
      private var curSortList:Array;
      
      public function RavePartySortRewardFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         vBox = ComponentFactory.Instance.creatComponentByStylename("RavePartySortRewardFrame.vBox");
         alertText = ComponentFactory.Instance.creatComponentByStylename("RavePartySortRewardFrame.alertText");
         addToContent(vBox);
         addToContent(alertText);
         alertText.text = LanguageMgr.GetTranslation("RavePartySortRewardFrame.alertText.text");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
      }
      
      public function set rewardType(param1:int) : void
      {
         var _loc7_:int = 0;
         var _loc5_:RavePartyRewardInfo = null;
         var _loc11_:Component = null;
         var _loc8_:HBox = null;
         var _loc6_:FilterFrameText = null;
         var _loc9_:int = 0;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:BaseItemView = null;
         var _loc10_:GoodsInfo = null;
         _rewardType = param1;
         vBox.removeAllChild();
         if(_rewardType != 7 && _rewardType != 8)
         {
            return;
         }
         if(_rewardType == 7)
         {
            curSortList = model.guildSortRewardList;
         }
         else if(_rewardType == 8)
         {
            curSortList = model.serverSortRewardList;
         }
         _loc7_ = 0;
         while(_loc7_ < curSortList.length)
         {
            _loc5_ = curSortList[_loc7_];
            _loc11_ = new Component();
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("RavePartySortRewardFrame.rewardHbox");
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("RavePartySortRewardFrame.sortText");
            _loc9_ = 1;
            while(_loc9_ <= 6)
            {
               _loc2_ = _loc5_["rewardItem" + _loc9_];
               if(!(_loc2_ == null || _loc2_ == ""))
               {
                  _loc3_ = _loc2_.split("|");
                  _loc4_ = ComponentFactory.Instance.creatCustomObject("RavePartySortRewardFrame.gItem");
                  _loc10_ = new GoodsInfo();
                  _loc10_.templateId = _loc3_[0];
                  _loc10_.count = _loc3_[1];
                  _loc4_.data = _loc10_;
                  _loc8_.addChild(_loc4_);
               }
               _loc9_++;
            }
            _loc6_.text = _loc5_.rewardRankStr;
            _loc11_.addChild(_loc6_);
            _loc11_.addChild(_loc8_);
            vBox.addChild(_loc11_);
            _loc7_++;
         }
         vBox.commitChanges();
         this.width = alertText.width + 40;
         this.height = vBox.height + 110;
         alertText.x = (this.width - alertText.textWidth) / 2 - 25;
         alertText.y = vBox.y + vBox.height + 20;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get model() : RavePartyModel
      {
         return RavePartyManager.instance.model;
      }
      
      public function show() : void
      {
         this.titleText = LanguageMgr.GetTranslation("PetChallengeInfoView.lookReward");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         if(alertText)
         {
            ObjectUtils.disposeObject(alertText);
         }
         alertText = null;
         if(vBox)
         {
            ObjectUtils.disposeObject(vBox);
         }
         vBox = null;
         super.dispose();
      }
   }
}

