package battle.view.bottom
{
   import battle.BattleManager;
   import battle.view.ui.MonsterCommonSkillItemListView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.MonsterRoleInfo;
   import yishi.manager.NotificationManager;
   
   public class MonsterCommonBottomBar extends Component
   {
      
      private var _back:Bitmap;
      
      private var _hpTxt:FilterFrameText;
      
      private var _skillList:MonsterCommonSkillItemListView;
      
      private var _selfBloodView:MonsterSelfBloodView;
      
      private var _ballRotate:Boolean;
      
      public function MonsterCommonBottomBar(param1:Boolean = true)
      {
         super();
         _ballRotate = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.battle.AbysmBattleBack");
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("battle.AbysmHpValueText");
         _selfBloodView = new MonsterSelfBloodView(this,-238,-91);
         _skillList = new MonsterCommonSkillItemListView();
         addChild(_back);
         _back.x = -_back.width * 0.5;
         _back.y = -_back.height;
         addChild(_hpTxt);
         addChild(_skillList);
         _skillList.x = -135;
         _skillList.y = -65;
         showVesselBall();
      }
      
      private function addEvent() : void
      {
         addEventListener("enterFrame",__enterFrame);
         NotificationManager.instance.addEventListener("sceneEffectClose",onSceneEffecCloseHandler);
      }
      
      private function onSceneEffecCloseHandler(param1:Event) : void
      {
         setBallRotation(false);
      }
      
      private function setBallRotation(param1:Boolean) : void
      {
         if(_selfBloodView)
         {
            _selfBloodView.setRotation(param1);
         }
      }
      
      private function showVesselBall() : void
      {
         _selfBloodView.showBall(_ballRotate);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         if(!selfInfo)
         {
            return;
         }
         var _loc2_:Number = Number(selfInfo.bloodA);
         _selfBloodView.updateHeroHp(_loc2_);
         _hpTxt.text = String(_loc2_);
         if(_loc2_ <= 0)
         {
            BattleManager.getInstance().battleModel.isOver = true;
            NotificationManager.instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("enterFrame",__enterFrame);
         NotificationManager.instance.removeEventListener("sceneEffectClose",onSceneEffecCloseHandler);
      }
      
      private function get selfInfo() : MonsterRoleInfo
      {
         return battleModel.selfMonsterRoleInfo;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_hpTxt);
         _hpTxt = null;
         ObjectUtils.disposeObject(_skillList);
         _skillList = null;
         ObjectUtils.disposeObject(_selfBloodView);
         _selfBloodView = null;
         super.dispose();
      }
   }
}

