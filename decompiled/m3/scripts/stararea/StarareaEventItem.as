package stararea
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.StarareaModel;
   import yishi.datas.templates.StarareaRoadsTemplate;
   import yishi.utils.FlickerHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class StarareaEventItem extends Sprite
   {
      
      private var _roadId:int;
      
      private var _mcRoad:MovieClip;
      
      private var _type:int;
      
      private var _hitAreaSp:Sprite;
      
      private var _temp:StarareaRoadsTemplate;
      
      private var _isLight:Boolean;
      
      private var _intervalTime:Number = 0;
      
      public function StarareaEventItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _hitAreaSp = new Sprite();
         _hitAreaSp.graphics.beginFill(16711680,0);
         _hitAreaSp.graphics.drawCircle(0,0,16);
         _hitAreaSp.graphics.endFill();
         _mcRoad = ComponentFactory.Instance.creatCustomObject("asset.stararea.mc.roadContent");
         addChild(_mcRoad);
         addChild(_hitAreaSp);
         _mcRoad.light.visible = false;
         _mcRoad.mouseEnabled = false;
         this.mouseEnabled = false;
         if(model.isInit)
         {
            FlickerHelper.setFilcker3(this);
         }
      }
      
      public function initParam(param1:StarareaRoadsTemplate, param2:int) : void
      {
         _temp = param1;
         _roadId = _temp.Id;
         _type = param2;
         _mcRoad.gotoAndStop(_type);
         initEvent();
      }
      
      private function initEvent() : void
      {
         _hitAreaSp.buttonMode = true;
         _hitAreaSp.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _hitAreaSp.removeEventListener("click",clickHandler);
      }
      
      private function get model() : StarareaModel
      {
         return StarareaManager.instance.model;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_type == 1)
         {
            return;
         }
         if(getTimer() - _intervalTime < 1000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _intervalTime = getTimer();
         var _loc2_:Boolean = false;
         var _loc4_:int = int(model.nodes[_temp.Node1 - 1]);
         var _loc3_:int = int(model.nodes[_temp.Node2 - 1]);
         if(_loc4_ != -1 && _loc3_ != -1)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stararea.road.click"));
            return;
         }
         switch(_type - 2)
         {
            case 0:
               if(!_isLight)
               {
                  return;
               }
               if(model.actionPower < model.oneStepActionPower)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("stararea.noPower"));
                  return;
               }
               StarareaManager.instance.moveRoad(_roadId);
               break;
            case 1:
               if(model.actionPower < model.oneStepActionPower)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("stararea.noPower"));
                  return;
               }
               StarareaManager.instance.moveRoad(_roadId);
               break;
            case 2:
               if(model.actionPower < model.oneStepActionPower)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("stararea.noPower"));
                  return;
               }
               model.gameRoadId = _roadId;
               StarareaManager.instance.startMiniGame();
               StarareaManager.instance.moveRoad(_roadId);
         }
      }
      
      public function set isLight(param1:Boolean) : void
      {
         _isLight = param1;
         _mcRoad.light.visible = _isLight;
      }
      
      public function dispose() : void
      {
         FlickerHelper.clearFilcker(this);
         removeEvent();
         ObjectUtils.disposeViolentMc(_mcRoad);
         _mcRoad = null;
         ObjectUtils.disposeObject(_hitAreaSp);
         _hitAreaSp = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _temp = null;
      }
   }
}

