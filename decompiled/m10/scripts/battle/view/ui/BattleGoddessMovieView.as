package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import battle.utils.BattleUtils;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.utils.getTimer;
   import utils.LogicUtils;
   import yishi.datas.BattleModel;
   import yishi.datas.battle.ResourceModel;
   import yishi.datas.objects.GoddessRoleInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class BattleGoddessMovieView extends Component implements IEnterFrame
   {
      
      private var _leftContiner:Component;
      
      private var _rightContiner:Component;
      
      private var leftMcList:Array;
      
      private var rightMcList:Array;
      
      private var preLeftTime:int = 0;
      
      private var preRightTime:int = 0;
      
      public function BattleGoddessMovieView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _leftContiner = ComponentFactory.Instance.creatComponentByStylename("BattleGoddessMovieView.leftContiner");
         _rightContiner = ComponentFactory.Instance.creatComponentByStylename("BattleGoddessMovieView.rightContiner");
         addChild(_leftContiner);
         addChild(_rightContiner);
         this.mouseChildren = this.mouseEnabled = false;
         _leftContiner.x = BattleUtils.rolePointByPos(4,1).x - 370;
         _leftContiner.y = StageReferance.stageHeight / 2 - 280;
         _rightContiner.x = BattleUtils.rolePointByPos(4,2).x - 180;
         _rightContiner.y = StageReferance.stageHeight / 2 - 280;
      }
      
      private function addEvent() : void
      {
         if(battleModel)
         {
            battleModel.addEventListener("BATTLE_OTHER_LIVING_VISIBLE",__visibleChangeHandler);
         }
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         if(battleModel)
         {
            battleModel.removeEventListener("BATTLE_OTHER_LIVING_VISIBLE",__visibleChangeHandler);
         }
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      private function __visibleChangeHandler(param1:BattleEvent) : void
      {
         removeShowMc();
      }
      
      private function removeShowMc() : void
      {
         leftMcList = [];
         rightMcList = [];
         preLeftTime = 0;
         preRightTime = 0;
         ObjectUtils.disposeAllChildren(_leftContiner);
         ObjectUtils.disposeAllChildren(_rightContiner);
      }
      
      public function setViewData(param1:Array) : void
      {
         var _loc2_:GoddessRoleInfo = null;
         removeShowMc();
         var _loc3_:Array = [];
         var _loc5_:Array = [];
         for each(var _loc4_:Object in param1)
         {
            _loc2_ = battleModel.getRoleById(_loc4_.livingId) as GoddessRoleInfo;
            if(_loc2_)
            {
               if(!battleModel.isHideOtherInBattle(_loc2_))
               {
                  if(_loc2_.face == 1)
                  {
                     _loc3_.push(_loc2_);
                  }
                  else if(_loc2_.face == 2)
                  {
                     _loc5_.push(_loc2_);
                  }
               }
            }
         }
         _loc3_.sortOn("pos",16);
         _loc5_.sortOn("pos",16);
         if(_loc3_.length > 0)
         {
            refreshMcView(_loc3_,leftMcList);
         }
         if(_loc5_.length > 0)
         {
            refreshMcView(_loc5_,rightMcList);
         }
      }
      
      private function refreshMcView(param1:Array, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:GoddessRoleInfo = null;
         var _loc3_:MovieClip = null;
         if(!resourceModel)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            _loc3_ = resourceModel.getOrCreateInstanse("asset.goddess.skill" + _loc5_.template.Type) as MovieClip;
            _loc3_.gotoAndStop(1);
            param2.push(_loc3_);
            _loc4_++;
         }
      }
      
      public function enterFrame() : void
      {
         enterFrameMc(leftMcList,_leftContiner,true);
         enterFrameMc(rightMcList,_rightContiner,false);
      }
      
      private function enterFrameMc(param1:Array, param2:Component, param3:Boolean) : void
      {
         var goddessMc:MovieClip;
         var mcList:Array = param1;
         var mcContiner:Component = param2;
         var isLeft:Boolean = param3;
         var curTime:int = isLeft ? preLeftTime : preRightTime;
         if(mcList.length > 0 && getTimer() - curTime >= 800)
         {
            goddessMc = mcList.shift() as MovieClip;
            goddessMc.addFrameScript(goddessMc.totalFrames - 1,function():void
            {
               resourceModel.recyleInstanse(goddessMc);
            });
            mcContiner.addChild(goddessMc);
            goddessMc.gotoAndPlay(1);
            isLeft ? (preLeftTime = getTimer()) : (preRightTime = getTimer());
         }
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      private function get resourceModel() : ResourceModel
      {
         return BattleManager.getInstance().resourceModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leftContiner);
         _leftContiner = null;
         ObjectUtils.disposeObject(_rightContiner);
         _rightContiner = null;
         LogicUtils.disposeDisplayCollection(leftMcList);
         leftMcList = null;
         LogicUtils.disposeDisplayCollection(rightMcList);
         rightMcList = null;
         super.dispose();
      }
   }
}

