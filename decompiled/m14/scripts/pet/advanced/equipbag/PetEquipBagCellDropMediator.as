package pet.advanced.equipbag
{
   import cell.mediator.CellDropMediator;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import managers.PetEquipManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class PetEquipBagCellDropMediator extends CellDropMediator
   {
      
      public function PetEquipBagCellDropMediator()
      {
         super();
      }
      
      override protected function __itemDropBagHandler(param1:NotificationEvent) : void
      {
         super.__itemDropBagHandler(param1);
         (_cell as PetEquipCell).setNormal();
      }
      
      override protected function __dragItemBagHandler(param1:NotificationEvent) : void
      {
         SoundManager.instance.play("003");
         super.__dragItemBagHandler(param1);
         var _loc2_:BaseItemView = BaseItemView(param1.data[0]);
         if(_loc2_ is PetEquipCell)
         {
            return;
         }
         if(!_loc2_.data)
         {
         }
         (_cell as PetEquipCell).setNormal();
      }
      
      override protected function starItemDrag(param1:int = -1) : void
      {
         SoundManager.instance.play("003");
         _cell.isDraging = true;
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [PetBagCell,BaseItemView,BaseIconView,Stage];
         _cell.setGrayFilter();
         NotificationManager.instance.sendNotification("PETEQUIPDROPSTART",_cell.data);
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc4_:BaseItemView = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _cell.isDraging = false;
         _cell.setNormalFilter();
         _loc4_ = param1.dropTarget as BaseItemView;
         NotificationManager.instance.sendNotification("PETEQUIPDROPOVER");
         if(param1.dropTarget is PetBagCell)
         {
            if(_loc4_ && _loc4_.data && _loc4_.data.templateInfo.MasterType == _cell.data.templateInfo.MasterType && _loc4_.data.templateInfo.SonType == _cell.data.templateInfo.SonType)
            {
               PlayerManager.instance.moveBagToBag(_loc4_.data.bagType,_loc4_.data.objectId,_loc4_.data.pos,26,_cell.data.objectId,_cell.data.pos,_loc4_.data.count,PetEquipManager.currSelectedPetData.petId);
            }
            else
            {
               _loc2_ = int(GoodsManager.instance.findEmputyPos());
               if(_loc2_ > 0)
               {
                  PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,1,0,_loc2_,_cell.data.count,PetEquipManager.currSelectedPetData.petId);
               }
            }
         }
         if(param1.dropTarget is PetEquipCell)
         {
            PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,26,0,_loc4_.pos,_cell.data.count,PetEquipManager.currSelectedPetData.petId);
         }
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
      
      protected function moveToEmptyPos() : void
      {
         var _loc2_:String = null;
         var _loc1_:int = int(GoodsManager.instance.findEmputyPos());
         if(_loc1_ == -1)
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.mediator.consortiabag.ConsortiaCaseCellClickMediator.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         SoundManager.instance.play("024",true);
         _cell.setGrayFilter();
         PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,1,0,_loc1_,1);
      }
      
      protected function swapItem(param1:BaseItemView, param2:BaseItemView, param3:int) : void
      {
         var _loc4_:GoodsInfo = _cell.data;
      }
      
      private function startMoveBagToBag(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         if(param1)
         {
            PlayerManager.instance.moveBagToBag(param3[0],param3[1],param3[2],param3[3],param3[4],param3[5],param3[6]);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

