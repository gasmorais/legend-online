package map.campaign.view.frame
{
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.internals.data.CampaignNode;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.WorldBossHelper;
   
   public class SacrificeRoomDialogFrame extends PetLandDialogFrame
   {
      
      public function SacrificeRoomDialogFrame()
      {
         super();
      }
      
      override protected function doSomething(param1:CampaignNode) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:int = int(CampaignManager.instance.mapId);
         if(WorldBossHelper.checkSacrificeRoom(_loc2_))
         {
            FrameControllerManager.instance.openControllerByInfo("sacrifice");
         }
      }
      
      override protected function initOptions(param1:Array) : void
      {
         var _loc3_:CampaignDialogOptionItem = null;
         var _loc4_:int = 0;
         var _loc5_:int = int(CampaignManager.instance.mapId);
         if(WorldBossHelper.checkSacrificeRoom(_loc5_))
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc3_ = new CampaignDialogOptionItem(mapId,_data.nodeId,param1[_loc4_],_loc4_);
               _vBox.addChild(_loc3_);
               _itemList[_loc4_] = _loc3_;
               _loc4_++;
            }
         }
         var _loc2_:String = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.leave");
         leaveItem = new CampaignDialogOptionItem(mapId,_data.nodeId,_loc2_,_itemList.length);
         _vBox.addChild(leaveItem);
         _itemList.push(leaveItem);
      }
   }
}

