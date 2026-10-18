package battle.view.ui
{
   import battle.BattleManager;
   import battle.utils.Helpers;
   import battle.view.BattleView;
   import battle.view.buffer.BossBufferContainer;
   import battle.view.ui.top.DoubleBossInfoView;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.manager.NotificationManager;
   
   public class RoleShowViewIII extends Sprite
   {
      
      private var _bossView:DoubleBossInfoView;
      
      private var _boss1:HeroRoleInfo;
      
      private var _boss2:HeroRoleInfo;
      
      public var bossBufferContainer1:BossBufferContainer;
      
      public var bossBufferContainer2:BossBufferContainer;
      
      public function RoleShowViewIII()
      {
         super();
         init();
         addEvent();
         layout();
      }
      
      private function init() : void
      {
         setBossInfo(battleModel.armyInfoRight.getHeros);
         createRightView();
      }
      
      private function createRightView() : void
      {
         _bossView = new DoubleBossInfoView();
         if(needExchange)
         {
            _bossView.setInfo(_boss2,_boss1);
            _bossView.setTotalHp(battleModel.armyInfoRight.getBossesTotalHpByInfo(_boss2),battleModel.armyInfoRight.getBossesTotalHpByInfo(_boss1));
            _bossView.setCurrentHp(battleModel.armyInfoRight.getBossesLeftHpByInfo(_boss2),battleModel.armyInfoRight.getBossesLeftHpByInfo(_boss1));
            bossBufferContainer1 = new BossBufferContainer(_boss2,1);
            bossBufferContainer2 = new BossBufferContainer(_boss1,1);
         }
         else
         {
            _bossView.setInfo(_boss1,_boss2);
            _bossView.setTotalHp(battleModel.armyInfoRight.getBossesTotalHpByInfo(_boss1),battleModel.armyInfoRight.getBossesTotalHpByInfo(_boss2));
            _bossView.setCurrentHp(battleModel.armyInfoRight.getBossesLeftHpByInfo(_boss1),battleModel.armyInfoRight.getBossesLeftHpByInfo(_boss2));
            bossBufferContainer1 = new BossBufferContainer(_boss1,1);
            bossBufferContainer2 = new BossBufferContainer(_boss2,1);
         }
         addChild(_bossView);
         bossBufferContainer1.x = 788;
         bossBufferContainer1.y = 61;
         addChild(bossBufferContainer1);
         bossBufferContainer2.x = 788;
         bossBufferContainer2.y = -8;
         addChild(bossBufferContainer2);
      }
      
      private function setBossInfo(param1:Dictionary) : void
      {
         var _loc2_:* = null;
         for each(var _loc3_:HeroRoleInfo in param1)
         {
            if(_loc3_.type == 3)
            {
               if(!_boss2)
               {
                  _boss2 = _loc3_;
               }
               else if(!_boss1)
               {
                  _boss1 = _loc3_;
               }
            }
         }
      }
      
      private function isNeedShowRightView() : Boolean
      {
         if(battleModel.battleType == 4 || battleModel.battleType == 7 || battleModel.battleType == 5 || battleModel.battleType == 10 || battleModel.battleType == 8)
         {
            return true;
         }
         return false;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      private function addEvent() : void
      {
         addEventListener("enterFrame",__enterFrame);
         StageReferance.stage.addEventListener("resize",__stageResize);
      }
      
      private function __stageResize(param1:Event) : void
      {
         layout();
      }
      
      private function layout() : void
      {
         resizeHeadView();
      }
      
      private function resizeHeadView() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:BattleView = BattleManager.getInstance().mainViewContainer.view;
         var _loc6_:Number = _loc3_.sceneWidth / 1500;
         _bossView.scaleX = _bossView.scaleY = _loc6_;
         _bossView.x = _loc3_.sceneWidth - _bossView.width * _loc6_;
         bossBufferContainer1.x = _loc3_.sceneWidth - 520 * _loc6_;
         bossBufferContainer2.x = _loc3_.sceneWidth - 520 * _loc6_;
         bossBufferContainer1.y = 75 * _loc6_ - 70;
         bossBufferContainer2.y = 160 * _loc6_ - 70;
         var _loc2_:Number = 1 / _loc6_;
         if(_bossView.nameTxt1)
         {
            _loc4_ = Number(_bossView.nameTxt1.width);
            _loc5_ = Number(_bossView.nameTxt1.textHeight);
            _bossView.nameTxt1.scaleX = _bossView.nameTxt1.scaleY = _loc2_;
            _bossView.nameTxt1.x += (_bossView.nameTxt1.width - _loc4_) / 2;
            _bossView.nameTxt1.y -= _bossView.nameTxt1.textHeight - _loc5_;
         }
         if(_bossView.nameTxt2)
         {
            _loc4_ = Number(_bossView.nameTxt2.width);
            _loc5_ = Number(_bossView.nameTxt2.textHeight);
            _bossView.nameTxt2.scaleX = _bossView.nameTxt2.scaleY = _loc2_;
            _bossView.nameTxt2.x -= (_bossView.nameTxt2.width - _loc4_) / 2;
            _bossView.nameTxt2.y -= _bossView.nameTxt2.textHeight - _loc5_;
         }
         var _loc1_:Point = localToGlobal(new Point(x,y));
         ChatTopBugleView.instance.setPos((_loc1_.x + 170) * _loc6_,(_loc1_.y + 90) * _loc6_,true);
      }
      
      private function __enterFrame(param1:Event) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:Number = Number(battleModel.armyInfoRight.getLeftHp());
         if(needExchange)
         {
            _loc3_ = Number(battleModel.armyInfoRight.getBossesLeftHpByInfo(_boss2));
            _loc4_ = Number(battleModel.armyInfoRight.getBossesLeftHpByInfo(_boss1));
         }
         else
         {
            _loc3_ = Number(battleModel.armyInfoRight.getBossesLeftHpByInfo(_boss1));
            _loc4_ = Number(battleModel.armyInfoRight.getBossesLeftHpByInfo(_boss2));
         }
         _bossView.setCurrentHp(_loc3_,_loc4_);
         if(_loc2_ <= 0)
         {
            BattleManager.getInstance().battleModel.isOver = true;
            NotificationManager.instance.sendNotification("FORCE_SKILL_ENABLE",false);
         }
      }
      
      private function get needExchange() : Boolean
      {
         return _boss1 && _boss2 && _boss1.pos > _boss2.pos;
      }
      
      public function dispose() : void
      {
         if(_bossView)
         {
            _bossView.dispose();
         }
         _bossView = null;
         if(bossBufferContainer1)
         {
            bossBufferContainer1.dispose();
         }
         bossBufferContainer1 = null;
         if(bossBufferContainer2)
         {
            bossBufferContainer2.dispose();
         }
         bossBufferContainer2 = null;
         Helpers.removeAllChildren(this);
         StageReferance.stage.removeEventListener("resize",__stageResize);
         removeEventListener("enterFrame",__enterFrame);
         if(parent)
         {
            parent.removeChild(this);
         }
         _boss1 = null;
         _boss2 = null;
      }
   }
}

