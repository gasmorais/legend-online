package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import battle.utils.Helpers;
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import utils.LogicUtils;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.manager.NotificationManager;
   
   public class DragonTitanTeamView extends Component
   {
      
      public var side:int = 1;
      
      private var _isHide:Boolean = false;
      
      private var _titanList:Vector.<DragonTitanIconItemView>;
      
      private var _fightBg:Image;
      
      private var _hidebtn:Image;
      
      private var _hideImgTxt:Image;
      
      private var _expandImgTxt:Image;
      
      private var _clickArea:Sprite;
      
      private var isTweening:Boolean = false;
      
      public function DragonTitanTeamView(param1:int = 1)
      {
         this.side = param1;
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DragonTitanIconItemView = null;
         _fightBg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.fightBg");
         _hidebtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.hidebtn");
         _hideImgTxt = ComponentFactory.Instance.creatComponentByStylename("dragontitan.hideImgTxt");
         _expandImgTxt = ComponentFactory.Instance.creatComponentByStylename("dragontitan.expandImgTxt");
         addChild(_fightBg);
         _clickArea = new Sprite();
         _clickArea.addChild(_hidebtn);
         _clickArea.addChild(_hideImgTxt);
         _clickArea.addChild(_expandImgTxt);
         addChild(_clickArea);
         if(isSingleBattle())
         {
            _fightBg.visible = false;
            _clickArea.visible = false;
         }
         _titanList = new Vector.<DragonTitanIconItemView>();
         if(isSelfSide())
         {
            _fightBg.scaleX *= -1;
            _fightBg.x = 120;
            _hidebtn.x = 100;
            _hideImgTxt.x = 97;
            _expandImgTxt.x = 97;
         }
         else
         {
            _hidebtn.x = 11;
            _hideImgTxt.x = 8;
            _expandImgTxt.x = 8;
         }
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new DragonTitanIconItemView();
            if(isSelfSide())
            {
               _loc1_.x = 13;
            }
            else
            {
               _loc1_.x = 40;
            }
            _loc1_.y = 13 + _loc2_ * 70;
            addChild(_loc1_);
            _titanList.push(_loc1_);
            _loc2_++;
         }
         refreshView();
      }
      
      private function isSelfSide() : Boolean
      {
         return BattleManager.getInstance().battleModel.selfSide == side;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      private function refreshView() : void
      {
         if(_isHide)
         {
            if(isSelfSide())
            {
               _hidebtn.scaleX = 1;
               _hidebtn.x = 100;
            }
            else
            {
               _hidebtn.scaleX = -1;
               _hidebtn.x = 21;
            }
            _hideImgTxt.visible = false;
            _expandImgTxt.visible = true;
         }
         else
         {
            if(isSelfSide())
            {
               _hidebtn.scaleX = -1;
               _hidebtn.x = 110;
            }
            else
            {
               _hidebtn.scaleX = 1;
               _hidebtn.x = 11;
            }
            _hideImgTxt.visible = true;
            _expandImgTxt.visible = false;
         }
         refreshData();
      }
      
      private function __refreshViewHandler(param1:BattleEvent) : void
      {
         refreshView();
      }
      
      private function refreshData() : void
      {
         var _loc1_:int = 0;
         _titanList[0].data = getDataObj(battleModel.heroList["0_" + side]);
         _titanList[1].data = getDataObj(battleModel.heroList["1_" + side]);
         _titanList[2].data = getDataObj(battleModel.heroList["2_" + side]);
         _titanList[3].data = getDataObj(battleModel.heroList["3_" + side]);
         if(isSingleBattle())
         {
            _loc1_ = 0;
            while(_loc1_ < _titanList.length)
            {
               if(!_titanList[_loc1_].data)
               {
                  _titanList[_loc1_].visible = false;
               }
               _loc1_++;
            }
         }
      }
      
      private function isSingleBattle() : Boolean
      {
         switch(int(battleModel.battleType) - 3842)
         {
            case 0:
            case 12:
               return false;
            default:
               if(battleModel.battleCapity == 1)
               {
                  return true;
               }
               switch(battleModel.battleType)
               {
                  case 18:
                  case 25:
                  case 3870:
                  case 13:
                  case 10:
                  case 290:
                  case 295:
                  case 310:
                  case 291:
                  case 3841:
                  case 3842:
                  case 314:
                  case 305:
                  case 3852:
                  case 3853:
                  case 3877:
                  case 3878:
                  case 3891:
                  case 3894:
                     break;
                  case 306:
                  case 307:
                  case 293:
                  case 3871:
                  case 3893:
                     return true;
                  default:
                     return getAttackerNum() == 1;
               }
               return false;
         }
      }
      
      private function getAttackerNum() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            if(battleModel.heroList[_loc2_ + "_" + side])
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function getDataObj(param1:HeroRoleInfo) : Object
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:Object = {};
         _loc2_.livingId = param1.livingId;
         _loc2_.titanId = param1.titanId;
         _loc2_.titanSkill = param1.titanSkill;
         return _loc2_;
      }
      
      private function initEvent() : void
      {
         if(_clickArea)
         {
            _clickArea.addEventListener("click",__clickHandler);
         }
         NotificationManager.instance.addEventListener("BATTLE_REINFORCE_HANDLER",__refreshViewHandler);
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         var toX:Number;
         var _sceneWidth:Number;
         var event:MouseEvent = param1;
         if(isTweening)
         {
            return;
         }
         _sceneWidth = Number(Helpers.limitRange(StageReferance.stage.stageWidth,1000,1500));
         if(_isHide)
         {
            if(isSelfSide())
            {
               toX = 0;
            }
            else
            {
               toX = _sceneWidth - 120;
            }
         }
         else if(isSelfSide())
         {
            toX = -91;
         }
         else
         {
            toX = _sceneWidth - 29;
         }
         _isHide = !_isHide;
         refreshView();
         isTweening = true;
         TweenLite.to(this,0.4,{
            "x":toX,
            "onComplete":function():void
            {
               isTweening = false;
            }
         });
      }
      
      private function removeEvent() : void
      {
         if(_clickArea)
         {
            _clickArea.removeEventListener("click",__clickHandler);
         }
         NotificationManager.instance.removeEventListener("BATTLE_REINFORCE_HANDLER",__refreshViewHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_fightBg);
         _fightBg = null;
         ObjectUtils.disposeObject(_hidebtn);
         _hidebtn = null;
         ObjectUtils.disposeObject(_hideImgTxt);
         _hideImgTxt = null;
         ObjectUtils.disposeObject(_expandImgTxt);
         _expandImgTxt = null;
         ObjectUtils.disposeObject(_clickArea);
         _clickArea = null;
         LogicUtils.disposeDisplayCollection(_titanList);
         _titanList = null;
         super.dispose();
      }
   }
}

