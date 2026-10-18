package monsterexplore.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import mvc.module.monsterexplore.MonsterExploreBattleInfo;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import utils.LogicUtils;
   import yishi.datas.templates.MonsterTempInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.MonsterExploreManager;
   import yishi.utils.MsgMan;
   
   public class MonsterExploreBattleView extends Component implements IEnterFrame
   {
      
      private var _monsterCon:Component;
      
      private var _pawnCon:Component;
      
      private var _mapMask:Component;
      
      private var monsterDic:Dictionary;
      
      private var pawnDic:Dictionary;
      
      private var MAX_AVATAR_COUNT:int = 3;
      
      private var lastExecuteTime:Number = 0;
      
      private var lastFrameRunTime:Number = 0;
      
      public function MonsterExploreBattleView()
      {
         super();
         initView();
         initBattleView();
         addEvent();
      }
      
      private function initView() : void
      {
         _monsterCon = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreBattleView.monsterCon");
         _pawnCon = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreBattleView.pawnCon");
         _mapMask = new Component();
         _mapMask.graphics.beginFill(16777215,1);
         _mapMask.graphics.drawRect(15,0,935,532);
         _mapMask.graphics.endFill();
         addChild(_monsterCon);
         addChild(_pawnCon);
         _pawnCon.x = 900;
         addChild(_mapMask);
         this.mask = _mapMask;
      }
      
      private function initBattleView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:MonsterExploreBattleAvatarView = null;
         var _loc1_:MonsterExploreBattleAvatarView = null;
         monsterDic = new Dictionary();
         _loc2_ = MAX_AVATAR_COUNT;
         while(_loc2_ > 0)
         {
            _loc3_ = new MonsterExploreBattleAvatarView(1,_loc2_);
            _monsterCon.addChild(_loc3_);
            monsterDic[_loc2_] = _loc3_;
            _loc3_.x = (MAX_AVATAR_COUNT - _loc2_) * 155;
            _loc2_--;
         }
         pawnDic = new Dictionary();
         _loc2_ = MAX_AVATAR_COUNT;
         while(_loc2_ > 0)
         {
            _loc1_ = new MonsterExploreBattleAvatarView(2,_loc2_);
            _pawnCon.addChild(_loc1_);
            pawnDic[_loc2_] = _loc1_;
            _loc1_.x = _loc2_ * 155;
            _loc2_--;
         }
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         MsgMan.addObserver("EXPLORE_EXP_CHANGE",this,__minExpChangeHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         MsgMan.removeObserver("EXPLORE_EXP_CHANGE",this,__minExpChangeHandler);
      }
      
      private function __minExpChangeHandler(param1:String, param2:Object) : void
      {
         var _loc4_:MonsterExploreBattleInfo = null;
         var _loc3_:Object = param2;
         if(!_loc3_ || _loc3_.type != 1)
         {
            return;
         }
         for each(var _loc5_:MonsterExploreBattleAvatarView in monsterDic)
         {
            _loc4_ = exploreModel.getBattleInfoByIndex(1,_loc5_.index);
            if(_loc4_ && _loc4_.hp > 0)
            {
               _loc5_.refreshExpView(_loc3_.exp);
            }
         }
      }
      
      public function enterFrame() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(exploreModel.exploreState == 1)
         {
            _loc3_ = getTimer();
            if(_pawnCon.x > 425 && lastExecuteTime > 0)
            {
               _loc1_ = exploreModel.moveSpeed * (_loc3_ - lastFrameRunTime);
               _loc2_ = _pawnCon.x - _loc1_;
               if(_loc2_ < 425)
               {
                  _loc2_ = 425;
               }
               _pawnCon.x = _loc2_;
               lastExecuteTime = getTimer();
               exploreModel.keepWalk = true;
            }
            lastFrameRunTime = getTimer();
            if(lastExecuteTime == 0)
            {
               lastExecuteTime = getTimer();
            }
         }
         else
         {
            exploreModel.keepWalk = false;
            lastExecuteTime = 0;
            lastFrameRunTime = 0;
         }
      }
      
      private function initBattleState() : void
      {
         if(exploreModel.exploreState == 0)
         {
            _pawnCon.x = 900;
         }
         else if(exploreModel.exploreState == 1)
         {
            _pawnCon.x = 425 + 475 / 10 * exploreModel.stateTime;
         }
         else
         {
            _pawnCon.x = 425;
         }
      }
      
      public function refreshView(param1:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:MonsterExploreBattleInfo = null;
         var _loc3_:Boolean = getSelfWin();
         if(param1)
         {
            initBattleState();
         }
         var _loc7_:String = "Attack01";
         for each(var _loc6_:MonsterExploreBattleAvatarView in monsterDic)
         {
            _loc4_ = exploreModel.getBattleInfoByIndex(1,_loc6_.index);
            _loc6_.data = _loc4_;
            if(_loc4_ && _loc4_.hp >= 0)
            {
               _loc6_.actionAndPlay(getActionLabel(_loc4_,_loc3_));
            }
         }
         for each(var _loc2_:MonsterExploreBattleAvatarView in pawnDic)
         {
            _loc4_ = exploreModel.getBattleInfoByIndex(2,_loc2_.index);
            _loc2_.data = _loc4_;
            if(_loc4_ && (_loc4_.tempInfo as PawnTemplate).DefaultSkill != 0)
            {
               _loc7_ = "Attack0" + (_loc4_.tempInfo as PawnTemplate).DefaultSkill;
            }
            if(_loc4_ && _loc4_.hp >= 0)
            {
               _loc2_.actionAndPlay(getActionLabel(_loc4_,!_loc3_));
            }
         }
      }
      
      private function getActionLabel(param1:MonsterExploreBattleInfo, param2:Boolean) : String
      {
         var _loc4_:String = null;
         if(!param1)
         {
            return "";
         }
         var _loc3_:String = "";
         if(param1.isMonster)
         {
            _loc3_ = (param1.tempInfo as MonsterTempInfo).DefaultAttack;
         }
         else if((param1.tempInfo as PawnTemplate).DefaultSkill != 0)
         {
            _loc3_ = "Attack0" + (param1.tempInfo as PawnTemplate).DefaultSkill;
         }
         switch(int(exploreModel.exploreState))
         {
            case 0:
               _loc4_ = "Stand";
               break;
            case 1:
               if(param1.isMonster)
               {
                  _loc4_ = "Walk";
               }
               else
               {
                  _loc4_ = "Stand";
               }
               break;
            case 2:
               _loc4_ = _loc3_;
               break;
            case 3:
               if(param2)
               {
                  _loc4_ = "Victory";
                  break;
               }
               _loc4_ = "Stand";
         }
         return _loc4_;
      }
      
      private function getSelfWin() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:MonsterExploreBattleInfo = null;
         for each(var _loc3_:MonsterExploreBattleAvatarView in monsterDic)
         {
            _loc2_ = exploreModel.getBattleInfoByIndex(1,_loc3_.index);
            if(_loc2_)
            {
               _loc1_ += _loc2_.hp;
            }
         }
         return _loc1_ > 0;
      }
      
      private function get exploreModel() : MonsterExploreModel
      {
         return MonsterExploreManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_monsterCon);
         _monsterCon = null;
         ObjectUtils.disposeObject(_pawnCon);
         _pawnCon = null;
         ObjectUtils.disposeObject(_mapMask);
         _mapMask = null;
         LogicUtils.disposeDisplayCollection(monsterDic);
         monsterDic = null;
         LogicUtils.disposeDisplayCollection(pawnDic);
         pawnDic = null;
         super.dispose();
      }
   }
}

