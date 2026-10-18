package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.FrameController;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesGridInfo;
   import yishi.datas.templates.PlanesEventsTemplateInfo;
   import yishi.datas.templates.PlanesLayerTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PlanesWarControler extends FrameController
   {
      
      private var eventFrameObj:Object = {
         1:"planeswar.view.PlanesCommonEventFrame",
         2:"planeswar.view.PlanesCommonEventFrame",
         3:"planeswar.view.PlanesBlackFrame",
         12:"planeswar.view.PlanesCommonEventFrame",
         13:"planeswar.view.PlanesCommonEventFrame",
         14:"planeswar.view.PlanesCommonEventFrame"
      };
      
      private var _preClickTime:Number;
      
      public function PlanesWarControler()
      {
         super();
      }
      
      public function openEventFrameByEventType(param1:int) : void
      {
         if(eventFrameObj[param1] == null)
         {
            return;
         }
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename(eventFrameObj[param1]);
         _loc2_["show"]();
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      public function moveGridByXY(param1:int, param2:int) : void
      {
         var _loc5_:PlanesLayerTemplateInfo = TempleteManager.instance.planesLayerTemplateCate.getTemplateByID(model.planesWarInfo.layerTempId);
         var _loc6_:PlanesGridInfo = model.getGridByXY(param1,param2);
         if(!_loc5_ || !_loc6_)
         {
            return;
         }
         var _loc7_:PlanesEventsTemplateInfo = TempleteManager.instance.planesEventsTemplateCate.getTemplateByID(_loc6_.eventId);
         if(model.planesWarInfo.dead)
         {
            return;
         }
         var _loc10_:Number = getTimer();
         if(_loc10_ - _preClickTime < 500)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _preClickTime = _loc10_;
         if(_loc6_.x == model.planesWarInfo.posX && _loc6_.y == model.planesWarInfo.posY)
         {
            if(_loc6_.frontBase && _loc6_.occupyName == PlayerManager.instance.currentPlayerModel.playerInfo.nickName)
            {
               return;
            }
            if(_loc7_)
            {
               if(ArmyManager.instance.thane.grades < _loc7_.NeedLevel)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("planeswar.planesArmyMove.gradeNoEventAlert"));
                  return;
               }
               if(model.energyLeft < model.getEventCostEnergyByResistance(_loc5_,_loc7_))
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("planeswar.planesArmyMove.energtNoEventAlert"));
                  return;
               }
            }
            PlanesWarManager.instance.sendPlanesOpMsg(2,[_loc6_.x,_loc6_.y]);
            PlanesWarManager.instance.isNeedOpendEventFrame = true;
            return;
         }
         if(_loc7_ && _loc7_.EventType == -1)
         {
            return;
         }
         var _loc8_:Point = new Point(model.planesWarInfo.posX,model.planesWarInfo.posY);
         var _loc9_:Point = new Point(_loc6_.x,_loc6_.y);
         var _loc3_:Array = model.walkPath(_loc8_,_loc9_);
         if(_loc3_ == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("planeswar.PlanesGridIconView.noPathAlert"));
            return;
         }
         model.selfArmy.walkPath = _loc3_;
         model.endPoint = new Point(_loc6_.x,_loc6_.y);
         var _loc4_:MovieClip = PlanesWarManager.instance.mapView.walkLayer.walkTarget;
         _loc4_.visible = true;
         _loc4_.play();
         _loc4_.x = _loc9_.x * 100 + 50;
         _loc4_.y = _loc9_.y * 100;
      }
   }
}

