package map.campaign.view.frame
{
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.net.MapSocketOuterManager;
   import yishi.utils.WorldBossHelper;
   
   public class ConsortiaBossDialogFrame extends PetLandDialogFrame
   {
      
      public function ConsortiaBossDialogFrame()
      {
         super();
      }
      
      override protected function __onClickHandler(param1:MouseEvent) : void
      {
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
               MapSocketOuterManager.sendFrameCallBack(mapId,_data.nodeId,true);
               dispose();
            }
         }
      }
      
      override protected function initOptions(param1:Array) : void
      {
         var _loc3_:CampaignDialogOptionItem = null;
         var _loc4_:int = 0;
         var _loc5_:int = int(CampaignManager.instance.mapId);
         if(WorldBossHelper.checkConsortiaEmeDream(_loc5_))
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

