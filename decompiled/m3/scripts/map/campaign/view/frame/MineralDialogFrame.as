package map.campaign.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.MineralCarInfo;
   import map.campaign.data.MineralModel;
   import map.internals.data.CampaignNode;
   import map.net.MapSocketOuterManager;
   import yishi.manager.SharedManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class MineralDialogFrame extends PetLandDialogFrame
   {
      
      private static const GET_CAR:int = 3000003;
      
      private static const HAND_IN:int = 3000004;
      
      private static const GET_CAR2:int = 3000102;
      
      private static const HAND_IN2:int = 3000103;
      
      public function MineralDialogFrame()
      {
         super();
      }
      
      override protected function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(_data)
         {
            if(param1.target == leaveItem)
            {
               MapSocketOuterManager.sendFrameCallBack(mapId,_data.nodeId,false);
               dispose();
            }
            else if(param1.target is CampaignDialogOptionItem)
            {
               if(needAlert)
               {
                  _loc4_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
                  _loc3_ = LanguageMgr.GetTranslation("map.campaign.view.frame.MineralDialogFrame.handInAlert");
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
                  _loc4_.show(_loc3_,_loc2_,handInAlertBack,null,"center");
               }
               else
               {
                  MapSocketOuterManager.sendFrameCallBack(mapId,_data.nodeId,true);
                  dispose();
               }
            }
         }
      }
      
      protected function handInAlertBack(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.handInMineralDate = new Date();
            SharedManager.instance.saveHandInMineralAlert();
         }
         MapSocketOuterManager.sendFrameCallBack(mapId,_data.nodeId,true);
         dispose();
      }
      
      protected function get needAlert() : Boolean
      {
         return (_data.nodeId == 3000004 || _data.nodeId == 3000103) && selfCarInfo.minerals < 200 && selfCarInfo.pick_count < 100 && selfCarInfo.is_own == 1 && Boolean(SharedManager.instance.checkIsExpired(SharedManager.instance.handInMineralDate));
      }
      
      override protected function initOptions(param1:Array) : void
      {
         var _loc4_:CampaignDialogOptionItem = null;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = int(CampaignManager.instance.mapId);
         if(WorldBossHelper.checkMineral(_loc6_))
         {
            _loc2_ = param1[_loc5_] + LanguageMgr.GetTranslation("public.parentheses1",count + " / " + mineralModel.maxCount);
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               _loc4_ = new CampaignDialogOptionItem(mapId,_data.nodeId,_loc2_,_loc5_);
               _vBox.addChild(_loc4_);
               _itemList[_loc5_] = _loc4_;
               _loc5_++;
            }
         }
         var _loc3_:String = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.leave");
         leaveItem = new CampaignDialogOptionItem(mapId,_data.nodeId,_loc3_,_itemList.length);
         _vBox.addChild(leaveItem);
         _itemList.push(leaveItem);
      }
      
      override public function show(param1:CampaignNode) : void
      {
         if(!selfCarInfo)
         {
            dispose();
            return;
         }
         super.show(param1);
      }
      
      private function get count() : int
      {
         var _loc1_:int = 0;
         if(_data.nodeId == 3000003 || _data.nodeId == 3000102)
         {
            _loc1_ = mineralModel.maxCount - selfCarInfo.get_count;
         }
         else if(_data.nodeId == 3000004 || _data.nodeId == 3000103)
         {
            _loc1_ = mineralModel.maxCount - selfCarInfo.hand_count;
         }
         return _loc1_;
      }
      
      private function get mineralModel() : MineralModel
      {
         return CampaignManager.instance.mineralModel;
      }
      
      private function get selfCarInfo() : MineralCarInfo
      {
         return CampaignManager.instance.mineralModel.selfCarInfo;
      }
   }
}

