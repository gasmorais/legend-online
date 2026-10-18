package cell.mediator.fashionbag
{
   import cell.mediator.CellDropMediator;
   import cell.view.fashionbag.FashionBagCell;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Stage;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.fashion.FashionModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class FashionBagCellDropMediator extends CellDropMediator
   {
      
      public function FashionBagCellDropMediator()
      {
         super();
      }
      
      override protected function starItemDrag(param1:int = -1) : void
      {
         if(fashionModel.selectedPanel != "FASHION_COMPOSE_PANEL" && fashionModel.selectedPanel != "FASHION_SWITCH_PANEL")
         {
            return;
         }
         if(fashionModel.opState == 1)
         {
            return;
         }
         if(fashionModel.opState == 2)
         {
            fashionModel.resetMovieclip();
         }
         SoundManager.instance.play("003");
         _cell.isDraging = true;
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{"icon":getDragIconObj()});
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [FashionBagCell,Stage];
         _cell.setGrayFilter();
      }
      
      override public function beDropHitCallBack(param1:GameDrag) : void
      {
         if(fashionModel.selectedPanel != "FASHION_COMPOSE_PANEL" && fashionModel.selectedPanel != "FASHION_SWITCH_PANEL")
         {
            return;
         }
         _cell.isDraging = false;
         _cell.setNormalFilter();
         var _loc3_:BaseItemView = param1.dropTarget as FashionBagCell;
         var _loc2_:int = param1.data > 0 ? param1.data : 1;
         if(_loc3_ is FashionBagCell)
         {
            if(check(_cell,_loc3_))
            {
               swapItem(_cell,_loc3_,_loc2_);
            }
         }
      }
      
      private function merger(param1:GoodsInfo, param2:GoodsInfo) : void
      {
         var _loc3_:Array = [];
         _loc3_.push(param1.bagType);
         _loc3_.push(param1.objectId);
         _loc3_.push(param1.pos);
         _loc3_.push(param2.bagType);
         _loc3_.push(param2.objectId);
         _loc3_.push(param2.pos);
         _loc3_.push(param1.count);
         startMoveBagToBag(true,true,_loc3_);
      }
      
      private function startMoveBagToBag(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         if(param1)
         {
            PlayerManager.instance.moveBagToBag.apply(null,param3);
         }
      }
      
      private function check(param1:BaseItemView, param2:BaseItemView) : Boolean
      {
         if(param2.bagType == 1)
         {
            if(param1.bagType == 1)
            {
               if(param1.data && param2.data && param1.data.templateId == 208020 && param2.data.templateId == 208020)
               {
                  merger(param1.data,param2.data);
               }
               return false;
            }
            if(param1.bagType == 0)
            {
               return true;
            }
         }
         var _loc3_:Array = GoodsManager.instance.getGoodsByBagType(0);
         if(param2.bagType == 0 && param1.bagType == 0)
         {
            return true;
         }
         if(param2.bagType == 0)
         {
            for each(var _loc4_:GoodsInfo in _loc3_)
            {
               if(param1.data.templateId == 208020)
               {
                  if(_loc4_.pos != param2.pos && _loc4_.templateId == param1.data.templateId)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("fashion.view.compose.oneEquipLess"));
                     return false;
                  }
               }
               else if(_loc4_.pos != param2.pos && _loc4_.templateId != 208020 && _loc4_.templateInfo.SonType != param1.data.templateInfo.SonType)
               {
                  if(fashionModel.selectedPanel == "FASHION_COMPOSE_PANEL")
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("fashion.FashionComposeView.sontypeCannotCompose"));
                  }
                  else if(fashionModel.selectedPanel == "FASHION_SWITCH_PANEL")
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("fashion.FashionSwitchView.sontypeCannotSwitch"));
                  }
                  return false;
               }
            }
         }
         if(fashionModel.lookDragonTalkerFashion && param1.data.templateInfo && param1.data.templateInfo.Job != "99" && param1.data.templateInfo.SonType != 278)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.fashionbag.tips2"));
            return false;
         }
         if(!fashionModel.lookDragonTalkerFashion && param1.data.templateInfo && param1.data.templateInfo.Job == "99")
         {
            if(!DragonTalkerManager.instance.model.isOpen)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.fashionbag.tips3"));
               return false;
            }
            if(!VersionSwitch.DRAGONIC_FASHION)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.fashionbag.tips4"));
               return false;
            }
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.fashionbag.tips1"));
            return false;
         }
         return true;
      }
      
      protected function swapItem(param1:BaseItemView, param2:BaseItemView, param3:int) : void
      {
         if(param2.pos >= 0)
         {
            PlayerManager.instance.moveBagToBag(param1.data.bagType,param1.data.objectId,param1.data.pos,param2.bagType,param2.objectId,param2.pos,param3);
         }
         else if(param2.pos == -1 && param1.data.bagType == 0)
         {
            PlayerManager.instance.moveBagToBag(param1.data.bagType,param1.data.objectId,param1.data.pos,1,0,0,param3);
         }
      }
      
      private function getFashionLevelByInfo(param1:GoodsInfo) : int
      {
         if(!param1)
         {
            return 0;
         }
         if(param1.templateId == 208020)
         {
            return 1;
         }
         if(param1.templateId == 208021)
         {
            return 1;
         }
         var _loc2_:int = param1.randomSkill1;
         if(!TempleteManager.instance.getSkillTemplateInfoById(param1.randomSkill1))
         {
            _loc2_ = int(param1.templateInfo.DefaultSkill.split(",")[0]);
         }
         return TempleteManager.instance.getSkillTemplateInfoById(_loc2_).Grades;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
   }
}

