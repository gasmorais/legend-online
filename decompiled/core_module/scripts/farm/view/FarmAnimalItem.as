package farm.view
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.data.FarmLandInfo;
   import farm.data.FriendFarmStateInfo;
   import farm.event.FarmEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.PathManager;
   import yishi.view.tips.MessageTipManager;
   
   public class FarmAnimalItem extends Component
   {
      
      private static const ACTION_WALK:int = 0;
      
      private static const ACTION_STAND:int = 4;
      
      private static const ACTION_WAITSEE:int = 2;
      
      private static const ACTION_CHEW:int = 3;
      
      private static const ACTION_FORAGING:int = 1;
      
      private static const ACTION_DIC:Object = {
         0:8,
         1:6,
         2:6,
         3:6,
         4:6
      };
      
      private static const ACTION_START_FRAME:Object = {
         0:0,
         1:26,
         2:14,
         3:20,
         4:8
      };
      
      private static const ACTION_LIST:Array = [[9,21,9,9,9,9,9,9,9,21,9,9,15,9,9,9,9,9,9,9,15,9,9,27,9,9,9,9,9,27,9,9,9,9,1,9,9,9,9,1,9,9,9,9,11,23,11,11,11,11,11,11,11,23,11,11,17,11,11,11,11,11,11,11,17,11,11,29,11,11,11,11,11,29,11,11,11,11,3,11,11,11,11,3,11,11,11,11],[9,21,9,9,9,9,9,9,9,21,9,9,15,9,9,9,9,9,9,9,15,9,9,27,9,9,9,9,9,27,9,9,9,9,1,9,9,9,9,1,9,9,9,9,13,25,13,13,13,13,13,13,13,25,13,13,19,13,13,13,13,13,13,13,19,13,13,31,13,13,13,13,13,31,13,13,13,13,5,13,13,13,13,5,13,13,13,13,11,23,11,11,11,11,11,11,11,23,11,11,17,11,11,11,11,11,11,11,17,11,11,29,11,11,11,11,11,29,11,11,11,11,3,11,11,11,11,3,11,11,11,11],[9,21,9,9,9,9,9,9,9,21,9,9,15,9,9,9,9,9,9,9,15,9,9,27,9,9,9,9,9,27,9,9,9,9,1,9,9,9,9,1,9,9,9,9,14,26,14,14,14,14,14,14,14,26,14,14,20,14,14,14,14,14,14,14,20,14,14,32,14,14,14,14,14,32,14,14,14,14,6,14,14,14,14,6,14,14,14,14,12,24,12,12,12,12,12,12,12,24,12,12,18,12,12,12,12,12,12,12,18,12,12,30,12,12,12,12,12,30,12,12,12,12,4,12,12,12,12,4,12,12,12,12],[9,21,9,9,9,9,9,9,9,21
      ,9,9,15,9,9,9,9,9,9,9,15,9,9,27,9,9,9,9,9,27,9,9,9,9,1,9,9,9,9,1,9,9,9,9,13,25,13,13,13,13,13,13,13,25,13,13,19,13,13,13,13,13,13,13,19,13,13,31,13,13,13,13,13,31,13,13,13,13,5,13,13,13,13,5,13,13,13,13,11,23,11,11,11,11,11,11,11,23,11,11,17,11,11,11,11,11,11,11,17,11,11,29,11,11,11,11,11,29,11,11,11,11,3,11,11,11,11,3,11,11,11,11,10,22,10,10,10,10,10,10,10,22,10,10,16,10,10,10,10,10,10,10,16,10,10,28,10,10,10,10,10,28,10,10,10,10,2,10,10,10,10,2,10,10,10,10],[9,21,9,9,9,9,9,9,9,21,9,9,15,9,9,9,9,9,9,9,15,9,9,27,9,9,9,9,9,27,9,9,9,9,1,9,9,9,9,1,9,9,9,9,14,26,14,14,14,14,14,14,14,26,14,14,20,14,14,14,14,14,14,14,20,14,14,32,14,14,14,14,14,32,14,14,14,14,6,14,14,14,14,6,14,14,14,14,12,24,12,12,12,12,12,12,12,24,12,12,18,12,12,12,12,12,12,12,18,12,12,30,12,12,12,12,12,30,12,12,12,12,4,12,12,12,12,4,12,12,12,12,10,22,10,10,10,10,10,10,10,22,10,10,16,10,10,10,10,10,10,10,16,10,10,28,10,10,10,10,10,28,10,10,10,10,2,10,10,10,10,2,10,10,10,10],[9,21,9,9,9,9,9,9,9,21,9,9,15,9,9,9,9,9,9,9,15,9,9,27
      ,9,9,9,9,9,27,9,9,9,9,1,9,9,9,9,1,9,9,9,9,13,25,13,13,13,13,13,13,13,25,13,13,19,13,13,13,13,13,13,13,19,13,13,31,13,13,13,13,13,31,13,13,13,13,5,13,13,13,13,5,13,13,13,13,11,23,11,11,11,11,11,11,11,23,11,11,17,11,11,11,11,11,11,11,17,11,11,29,11,11,11,11,11,29,11,11,11,11,3,11,11,11,11,3,11,11,11,11,10,22,10,10,10,10,10,10,10,22,10,10,16,10,10,10,10,10,10,10,16,10,10,28,10,10,10,10,10,28,10,10,10,10,2,10,10,10,10,2,10,10,10,10,12,24,12,12,12,12,12,12,12,24,12,12,18,12,12,12,12,12,12,12,18,12,12,30,12,12,12,12,12,30,12,12,12,12,4,12,12,12,12,4,12,12,12,12,14,26,14,14,14,14,14,14,14,26,14,14,20,14,14,14,14,14,14,14,20,14,14,32,14,14,14,14,14,32,14,14,14,14,6,14,14,14,14,6,14,14,14,14],[9,21,9,9,9,9,9,9,9,21,9,9,15,9,9,9,9,9,9,9,15,9,9,27,9,9,9,9,9,27,9,9,9,9,1,9,9,9,9,1,9,9,9,9,14,26,14,14,14,14,14,14,14,26,14,14,20,14,14,14,14,14,14,14,20,14,14,32,14,14,14,14,14,32,14,14,14,14,6,14,14,14,14,6,14,14,14,14,12,24,12,12,12,12,12,12,12,24,12,12,18,12,12,12,12,12,12,12,18,12,12,30,12,12,12,12
      ,12,30,12,12,12,12,4,12,12,12,12,4,12,12,12,12,10,22,10,10,10,10,10,10,10,22,10,10,16,10,10,10,10,10,10,10,16,10,10,28,10,10,10,10,10,28,10,10,10,10,2,10,10,10,10,2,10,10,10,10,11,23,11,11,11,11,11,11,11,23,11,11,17,11,11,11,11,11,11,11,17,11,11,29,11,11,11,11,11,29,11,11,11,11,3,11,11,11,11,3,11,11,11,11,13,25,13,13,13,13,13,13,13,25,13,13,19,13,13,13,13,13,13,13,19,13,13,31,13,13,13,13,13,31,13,13,13,13,5,13,13,13,13,5,13,13,13,13],[9,21,9,9,27,21,21,9,9,9,9],[13,25,13,13,31,25,25,13,13,13,13],[11,23,11,11,29,23,23,11,11,11,11],[10,22,10,10,28,22,22,10,10,10,10],[12,24,12,12,30,24,24,12,12,12,12],[14,26,14,14,32,26,26,14,14,14,14],[9,27,9,9,15,1,9,9,9,9,9],[13,31,13,13,19,5,13,13,13,13,13],[11,29,11,11,17,3,11,11,11,11,11],[10,28,10,10,16,2,10,10,10,10,10],[12,30,12,12,18,4,12,12,12,12,12],[14,32,14,14,20,6,14,14,14,14,14],[9,27,9,21,9,1,9,9,9,9,9],[13,31,13,25,13,5,13,13,13,13,13],[11,29,11,23,11,3,11,11,11,11,11],[10,28,10,22,10,2,10,10,10,10,10],[12,30,12,24,12,4,12,12,12,12,12],[14
      ,32,14,26,14,6,14,14,14,14,14],[9,27,15,9,9,27,9,9,9,9,9],[13,31,19,13,13,31,13,13,13,13,13],[11,29,17,11,11,29,11,11,11,11,11],[10,28,16,10,10,28,10,10,10,10,10],[12,30,18,12,12,30,12,12,12,12,12],[14,32,20,14,14,32,14,14,14,14,14],[9,1,9,9,9,15,27,9,9,9,9],[13,5,13,13,13,19,31,13,13,13,13],[11,3,11,11,11,17,29,11,11,11,11],[10,2,10,10,10,16,28,10,10,10,10],[12,4,12,12,12,18,30,12,12,12,12],[14,6,14,14,14,20,32,14,14,14,14],[9,1,27,9,9,9,9,9,9,9,9],[13,5,31,13,13,13,13,13,13,13,13],[11,3,29,11,11,11,11,11,11,11,11],[10,2,28,10,10,10,10,10,10,10,10],[12,4,30,12,12,12,12,12,12,12,12],[14,6,32,14,14,14,14,14,14,14,14],[9,1,9,9,15,27,27,9,9,9,9],[13,5,13,13,19,31,31,13,13,13,13],[11,3,11,11,17,29,29,11,11,11,11],[10,2,10,10,16,28,28,10,10,10,10],[12,4,12,12,18,30,30,12,12,12,12],[14,6,14,14,20,32,32,14,14,14,14]];
      
      private var _movePos:Array;
      
      private var _animalMc:MovieClip;
      
      private var _animalContent:Component;
      
      private var _data:FarmLandInfo;
      
      private var _path:String;
      
      private var _loader:Loader;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _w:int;
      
      private var _h:int;
      
      private var isInMouseBelow:Boolean = false;
      
      private var _filter:UIFilter;
      
      private var _isRefreshCursor:Boolean = false;
      
      private var _parent:FarmAnimalArea;
      
      private var currentAct:int = -1;
      
      private var currentDic:int;
      
      private var _curState:int;
      
      private var _curPhase:int;
      
      private var _hungerImg:Bitmap;
      
      private var _anxietyImg:Bitmap;
      
      private var _illImg:Bitmap;
      
      private var _harvestImg:Bitmap;
      
      private var _initPoint:Point;
      
      private var _hasOperEffect:MovieClip;
      
      private var _expEffect:MovieClip;
      
      private var _isWalk:Boolean = false;
      
      private var currentActList:Array;
      
      private var currentActIndex:int = 0;
      
      public function FarmAnimalItem(param1:FarmAnimalArea, param2:int, param3:int, param4:Array)
      {
         super();
         _filter = new UIFilter();
         _parent = param1;
         _w = param2;
         _h = param3;
         _movePos = param4;
         _hasOperEffect = ComponentFactory.Instance.creatCustomObject("farm.AnimalHasOperEffect");
         _hungerImg = ComponentFactory.Instance.creatBitmap("asset.farm.farmanimalitem.HungerImg");
         _anxietyImg = ComponentFactory.Instance.creatBitmap("asset.farm.farmanimalitem.AnxietyImg");
         _illImg = ComponentFactory.Instance.creatBitmap("asset.farm.farmanimalitem.IllImg");
         _harvestImg = ComponentFactory.Instance.creatBitmap("asset.farm.farmanimalitem.HarvestImg");
         _animalContent = ComponentFactory.Instance.creatComponentByStylename("farm.FarmAnimalItem.AnimalContent");
         addChild(_animalContent);
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(-50,-70,90,90);
         this.graphics.endFill();
         _expEffect = ComponentFactory.Instance.creatCustomObject("farm.ExpEffect");
         _expEffect.gotoAndStop(1);
         this.visible = false;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("mouseOver",onMouseOver);
         this.addEventListener("mouseOut",onMouseOut);
         addEventListener("click",__onItemClick);
         if(_animalMc != null)
         {
            _animalMc.addEventListener("ACTION_OVER",onAnimalActionOver);
         }
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseOver",onMouseOver);
         this.removeEventListener("mouseOut",onMouseOut);
         removeEventListener("click",__onItemClick);
         if(_animalMc != null)
         {
            _animalMc.removeEventListener("ACTION_OVER",onAnimalActionOver);
         }
      }
      
      private function onAnimalActionOver(param1:Event = null) : void
      {
         if(_isWalk)
         {
            return;
         }
         if(isInMouseBelow)
         {
            return;
         }
         nextAction();
      }
      
      private function nextAction() : void
      {
         if(currentActList == null)
         {
            return;
         }
         currentActIndex = currentActIndex + 1;
         var _loc1_:int = int(currentActList[currentActIndex]);
         if(_loc1_ <= 8)
         {
            if(canMove(_loc1_))
            {
               createAnimal();
            }
         }
         else
         {
            createAnimal();
         }
         if(currentActIndex >= currentActList.length)
         {
            currentActIndex = 0;
            currentActList = ACTION_LIST[int(Math.random() * ACTION_LIST.length)];
         }
      }
      
      private function canMove(param1:int) : Boolean
      {
         var _loc5_:Point = null;
         var _loc2_:Boolean = false;
         var _loc4_:int = _x;
         var _loc3_:int = _y;
         switch(param1 - 1)
         {
            case 0:
               if(_loc3_ < _h - 2)
               {
                  _loc3_ += 1;
               }
               break;
            case 1:
               if(_loc3_ > 0)
               {
                  _loc3_ -= 1;
               }
               break;
            case 2:
               if(_loc4_ > 0)
               {
                  _loc4_ -= 1;
               }
               break;
            case 3:
               if(_loc4_ < _w - 2)
               {
                  _loc4_ += 1;
               }
               break;
            case 4:
               if(_loc4_ > 0 && _loc3_ < _h - 2)
               {
                  _loc4_ -= 1;
                  _loc3_ += 1;
               }
               break;
            case 5:
               if(_loc4_ < _w - 2 && _loc3_ < _h - 2)
               {
                  _loc4_ += 1;
                  _loc3_ += 1;
               }
               break;
            case 6:
               if(_loc4_ > 0 && _loc3_ > 0)
               {
                  _loc4_ -= 1;
                  _loc3_ -= 1;
               }
               break;
            case 7:
               if(_loc4_ < _w - 2 && _loc3_ > 0)
               {
                  _loc4_ += 1;
                  _loc3_ -= 1;
               }
         }
         _loc2_ = !_parent.hasAnimalByPos(_loc4_,_loc3_);
         if(_loc2_)
         {
            _loc5_ = _movePos[_loc3_][_loc4_];
            if(_loc5_ != null)
            {
               _isWalk = true;
               TweenMax.to(this,4,{
                  "x":_loc5_.x,
                  "y":_loc5_.y,
                  "ease":Linear.easeNone,
                  "onComplete":onWalkOver
               });
            }
            _parent.cleanAnimalByPos(_x,_y);
            _x = _loc4_;
            _y = _loc3_;
         }
         return _loc2_;
      }
      
      private function onWalkOver() : void
      {
         _isWalk = false;
         onAnimalActionOver();
      }
      
      private function __onItemClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!_data)
         {
            return;
         }
         if(data.is_hunger)
         {
            FarmManager.instance.sendFarmOper(_data.userId,7,data.pos);
            return;
         }
         if(data.is_ill)
         {
            FarmManager.instance.sendFarmOper(_data.userId,5,data.pos);
            return;
         }
         if(data.is_gloomy)
         {
            FarmManager.instance.sendFarmOper(_data.userId,4,data.pos);
            return;
         }
         if(data.is_can_reap || data.isMature)
         {
            if(isSelf)
            {
               FarmManager.instance.sendFarmOper(_data.userId,6,data.pos);
            }
            else
            {
               _loc2_ = _data.canBeStolen;
               if(_loc2_ != "")
               {
                  MessageTipManager.instance().show(_loc2_);
                  cleanCanPickEffect();
                  farmManager.updateFarmStateByType(_data.userId,14,false);
                  return;
               }
               if(model.myFarm.dayStealCount >= model.maxDayStealCount)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.view.FarmLandItem.outStealCountTip"));
                  return;
               }
               FarmManager.instance.sendFarmOper(_data.userId,14,data.pos);
            }
            return;
         }
         ShowTipManager.Instance.removeCurrentTip();
         showMenu();
      }
      
      private function showMenu() : void
      {
         if(!isSelf)
         {
            return;
         }
         var _loc1_:Point = localToGlobal(new Point(_animalContent.x,_animalContent.y));
         var _loc2_:FarmOperMenu = new FarmOperMenu();
         _loc2_.data = _data;
         _loc2_.x = _loc1_.x - 70;
         _loc2_.y = _loc1_.y - 40;
         _loc2_.show();
      }
      
      private function get isSelf() : Boolean
      {
         var _loc1_:Boolean = true;
         if(_data.userId != thane.userId)
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         isInMouseBelow = true;
         if(_animalMc == null)
         {
            return;
         }
         if(tipData)
         {
            _filter.setLightingFilter(this);
            buttonMode = true;
            return;
         }
         if(!_data)
         {
            buttonMode = false;
            return;
         }
         if(_data.isSelfLand)
         {
            _filter.setLightingFilter(this);
            buttonMode = true;
         }
         else
         {
            buttonMode = false;
         }
         setCursorByOper();
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         isInMouseBelow = false;
         if(_animalMc != null)
         {
            _filter.setNormalFilter(this);
         }
         CursorManagerII.instance.resetCursor();
      }
      
      private function __completeHandler(param1:Event) : void
      {
         if(_loader == null)
         {
            return;
         }
         _loader.contentLoaderInfo.removeEventListener("complete",__completeHandler);
         _loader.unloadAndStop(true);
         _loader = null;
         currentActList = ACTION_LIST[int(Math.random() * ACTION_LIST.length)];
         createAnimal();
      }
      
      public function get path() : String
      {
         return _path;
      }
      
      public function set data(param1:FarmLandInfo) : void
      {
         _data = param1;
         clean();
         updateView();
         removeLandListener(_data);
         addLandListener(_data);
      }
      
      private function clean() : void
      {
         _curState = _curPhase = -1;
         cleanEffect();
      }
      
      private function cleanEffect() : void
      {
         _hasOperEffect.stop();
         if(_hasOperEffect.parent)
         {
            _hasOperEffect.parent.removeChild(_hasOperEffect);
         }
         if(_hungerImg.parent)
         {
            _hungerImg.parent.removeChild(_hungerImg);
         }
         if(_anxietyImg.parent)
         {
            _anxietyImg.parent.removeChild(_anxietyImg);
         }
         if(_illImg.parent)
         {
            _illImg.parent.removeChild(_illImg);
         }
         if(_harvestImg.parent)
         {
            _harvestImg.parent.removeChild(_harvestImg);
         }
      }
      
      private function cleanCanPickEffect() : void
      {
         _hasOperEffect.stop();
         if(_hasOperEffect.parent)
         {
            _hasOperEffect.parent.removeChild(_hasOperEffect);
         }
      }
      
      private function addLandListener(param1:FarmLandInfo) : void
      {
         if(param1)
         {
            param1.addEventListener("OPER_BACK",__operBackHandler);
         }
      }
      
      private function removeLandListener(param1:FarmLandInfo) : void
      {
         if(param1)
         {
            param1.removeEventListener("OPER_BACK",__operBackHandler);
         }
      }
      
      private function __operBackHandler(param1:FarmEvent) : void
      {
         var _loc2_:FarmInfo = model.curSelectedFarmInfo;
         if(!_data || !_loc2_ || _loc2_.userId != _data.userId)
         {
            return;
         }
         switch(_data.result)
         {
            case 0:
               addExpAndChatTip(_loc2_);
               updateFriendFarmState(_loc2_);
               if(_data.op_type != 1)
               {
                  _isRefreshCursor = true;
               }
               break;
            case 1:
               updateFriendFarmState(_loc2_);
         }
      }
      
      private function updateFriendFarmState(param1:FarmInfo) : void
      {
         var _loc3_:* = null;
         if(checkIsSelf(param1.userId))
         {
            return;
         }
         var _loc2_:Boolean = false;
         var _loc4_:FriendFarmStateInfo = model.getFarmStateInfo(param1.userId);
         for each(_loc3_ in param1.animalList)
         {
            if(_loc3_.hasCrop)
            {
               if(farmManager.checkHasOperNow(_loc3_,_data.op_type))
               {
                  _loc2_ = true;
               }
            }
         }
         _loc4_.beginChanges();
         switch(_data.op_type - 4)
         {
            case 0:
               _loc4_.canPacify = _loc2_;
               break;
            case 1:
               _loc4_.canCure = _loc2_;
               break;
            case 3:
               _loc4_.canFeedLivestock = _loc2_;
               break;
            case 10:
               _loc4_.canPastureSteal = _loc2_;
         }
         _loc4_.commitChanges();
      }
      
      private function addExpAndChatTip(param1:FarmInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = model.expByOper(_data.op_type);
         _expEffect.gotoAndStop("expEffect");
         if(_loc3_ <= 0)
         {
            switch(model.fullExpType - 1)
            {
               case 0:
                  _expEffect["expTxt"]["text"].text = LanguageMgr.GetTranslation("farm.view.FarmLandItem.farmExpFull");
                  break;
               case 1:
                  _expEffect["expTxt"]["text"].text = LanguageMgr.GetTranslation("farm.view.FarmLandItem.dayGpFull");
            }
         }
         else
         {
            _expEffect["expTxt"]["text"].text = LanguageMgr.GetTranslation("farm.view.FarmLandItem.farmExp") + "+" + _loc3_;
            _expEffect["expTxt"]["text"].setTextFormat(ComponentFactory.Instance.model.getSet("farm.FarmExp"));
         }
         switch(_data.op_type - 4)
         {
            case 0:
               _expEffect.play();
               addChild(_expEffect);
               break;
            case 1:
               _expEffect.play();
               addChild(_expEffect);
               break;
            case 3:
               _expEffect.play();
               addChild(_expEffect);
               break;
            case 5:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.view.FarmLandItem.accelerateSucceed"));
         }
         model.myFarm.gp += _loc3_;
         if(!checkIsSelf(param1.userId))
         {
            model.myFarm.dayGpFromFriend += _loc3_;
            _loc2_ = _data.cropTemp ? _data.cropTemp.TemplateName : "";
            farmManager.addChatTip(2,_data.op_type,param1.userId,param1.nickName,_loc2_,_loc3_);
         }
         else
         {
            farmManager.addChatTip(1,_data.op_type,0,"","",_loc3_);
         }
      }
      
      private function checkIsSelf(param1:int) : Boolean
      {
         return param1 == thane.userId;
      }
      
      private function get farmManager() : FarmManager
      {
         return FarmManager.instance;
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      public function get data() : FarmLandInfo
      {
         return _data;
      }
      
      public function set path(param1:String) : void
      {
         if(_path == param1)
         {
            return;
         }
         _path = param1;
         var _loc2_:String = "asset.farmanimal.Animal" + data.item_template_id;
         if(ApplicationDomain.currentDomain.hasDefinition(_loc2_))
         {
            createAnimal();
            return;
         }
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",__completeHandler);
         LoaderManagerII.instance.load(path,1,8,__onComplete);
      }
      
      private function createAnimal() : void
      {
         if(data == null || !data.cropTemp)
         {
            return;
         }
         var _loc2_:String = "asset.farmanimal." + data.cropTemp.Avata + getAction(currentActList[currentActIndex]) + getDic(currentActList[currentActIndex]);
         var _loc1_:Class = ApplicationDomain.currentDomain.getDefinition(_loc2_) as Class;
         _animalContent.tipData = data;
         if(_animalMc != null)
         {
            _animalMc.removeEventListener("ACTION_OVER",onAnimalActionOver);
            ObjectUtils.disposeObject(_animalMc);
         }
         _animalMc = new _loc1_() as MovieClip;
         _animalContent.addChild(_animalMc);
         dealDic(currentActList[currentActIndex]);
         if(_initPoint == null)
         {
            _initPoint = _parent.getInitPoint();
            if(_initPoint == null)
            {
               return;
            }
            _x = _initPoint.x;
            _y = _initPoint.y;
            this.x = _movePos[_y][_x].x;
            this.y = _movePos[_y][_x].y;
            this.visible = true;
         }
         addEvent();
      }
      
      private function getAction(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
               _loc2_ = "_1_";
               break;
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
               _loc2_ = "_2_";
               break;
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
               _loc2_ = "_3_";
               break;
            case 21:
            case 22:
            case 23:
            case 24:
            case 25:
            case 26:
               _loc2_ = "_4_";
               break;
            case 27:
            case 28:
            case 29:
            case 30:
            case 31:
            case 32:
               _loc2_ = "_5_";
         }
         return _loc2_;
      }
      
      private function getDic(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case 1:
            case 9:
            case 15:
            case 21:
            case 27:
               _loc2_ = "45";
               break;
            case 2:
            case 10:
            case 16:
            case 22:
            case 28:
            case 4:
            case 12:
            case 18:
            case 24:
            case 30:
               _loc2_ = "135";
               break;
            case 3:
            case 11:
            case 17:
            case 23:
            case 29:
               _loc2_ = "45";
               break;
            case 5:
               _loc2_ = "0";
               break;
            case 6:
               _loc2_ = "90";
               break;
            case 13:
            case 19:
            case 25:
            case 31:
            case 14:
            case 20:
            case 26:
            case 32:
               _loc2_ = "90";
         }
         return _loc2_;
      }
      
      private function dealDic(param1:int) : void
      {
         var _loc2_:Array = null;
         if(_animalMc != null)
         {
            _animalMc.scaleX = 1;
            _loc2_ = [2,3,7,19,11,14,16,17,20,22,23,26,28,29,32];
            if(_loc2_.indexOf(param1) != -1)
            {
               _animalMc.scaleX = -1;
            }
         }
      }
      
      private function __onComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(!_loader)
         {
            return;
         }
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         _loader.loadBytes(param2 as ByteArray,_loc3_);
      }
      
      public function updateView() : void
      {
         if(data.item_template_id == 0)
         {
            return;
         }
         var _loc1_:String = PathManager.getFarmAnimaSwfPath(data.cropTemp.Avata);
         path = _loc1_;
         refreshViewByStatePhase(_data.cropState,_data.cropPhase);
         if(_isRefreshCursor)
         {
            _isRefreshCursor = false;
            setCursorByOper();
         }
      }
      
      private function refreshViewByStatePhase(param1:int, param2:int) : void
      {
         var _loc3_:DisplayObject = null;
         if(_curState == param1 && _curPhase == param2)
         {
            return;
         }
         _curState = param1;
         cleanEffect();
         switch(param1 - 5)
         {
            case 0:
               _loc3_ = _anxietyImg;
               farmManager.updateFarmStateByType(_data.userId,4,true);
               break;
            case 1:
               _loc3_ = _illImg;
               farmManager.updateFarmStateByType(_data.userId,5,true);
               break;
            case 2:
               _loc3_ = _hungerImg;
               farmManager.updateFarmStateByType(_data.userId,7,true);
         }
         if(_loc3_ != null)
         {
            _hasOperEffect.addChild(_loc3_);
            addChild(_hasOperEffect);
            return;
         }
         _curPhase = param2;
         switch(param2 - 1)
         {
            case 0:
               cleanEffect();
               break;
            case 1:
               if(_curState != 3 && _curState != 4)
               {
                  cleanEffect();
               }
               break;
            case 2:
               cleanEffect();
               _loc3_ = _harvestImg;
         }
         if(!_loc3_)
         {
            return;
         }
         _hasOperEffect.addChild(_loc3_);
         addChild(_hasOperEffect);
      }
      
      private function setCursorByOper() : void
      {
         if(DragManager.getInstance().isDraging || DoubleClickManager.Instance.isClicking)
         {
            return;
         }
         if(data.is_hunger)
         {
            CursorManagerII.instance.showCursorByType("FARM_ANIMAL_HUNGER");
            return;
         }
         if(data.is_ill)
         {
            CursorManagerII.instance.showCursorByType("FARM_ANIMAL_ILL");
            return;
         }
         if(data.is_gloomy)
         {
            CursorManagerII.instance.showCursorByType("FARM_ANIMAL_ANXIET");
            return;
         }
         if(data.is_can_reap)
         {
            CursorManagerII.instance.showCursorByType("FARM_ANIMAL_HARVEST");
            return;
         }
         CursorManagerII.instance.resetCursor();
      }
      
      override public function dispose() : void
      {
         removeLandListener(_data);
         removeEvent();
         _movePos = null;
         if(_animalMc != null)
         {
            _animalMc.stop();
            ObjectUtils.disposeObject(_animalMc);
            _animalMc = null;
         }
         ObjectUtils.disposeObject(_animalContent);
         _animalContent = null;
         _parent = null;
         _data = null;
         ObjectUtils.disposeObject(_hungerImg);
         _hungerImg = null;
         ObjectUtils.disposeObject(_anxietyImg);
         _anxietyImg = null;
         ObjectUtils.disposeObject(_illImg);
         _illImg = null;
         ObjectUtils.disposeObject(_harvestImg);
         _harvestImg = null;
         ObjectUtils.disposeObject(_hasOperEffect);
         _hasOperEffect = null;
         ObjectUtils.disposeObject(_expEffect);
         _expEffect = null;
         currentActList = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

