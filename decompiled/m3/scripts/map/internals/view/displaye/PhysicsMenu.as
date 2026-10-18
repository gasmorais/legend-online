package map.internals.view.displaye
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import map.internals.constant.ArmyState;
   import map.internals.data.BaseCastle;
   import map.internals.data.CampaignNode;
   import map.internals.data.MapPhysics;
   import map.internals.data.WildLand;
   import map.internals.event.PhysicsMenuEvent;
   import mvc.module.armyII.BaseArmy;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class PhysicsMenu extends Sprite
   {
      
      private static var _instance:PhysicsMenu;
      
      private var _buttonsDict:Dictionary;
      
      private var _buttonsName:Dictionary;
      
      private var vbox:Sprite;
      
      private var _frameId:int;
      
      private var _callObj:Object;
      
      private var _parent:Sprite;
      
      private var _selectEffct:MovieClip;
      
      public function PhysicsMenu()
      {
         super();
         _frameId = 0;
         init();
         createSelectEffect();
      }
      
      public static function getInstance() : PhysicsMenu
      {
         if(!_instance)
         {
            _instance = new PhysicsMenu();
         }
         return _instance;
      }
      
      public function get frameId() : uint
      {
         return _frameId;
      }
      
      private function init() : void
      {
         getButtonsName();
         vbox = new Sprite();
         addChild(vbox);
         _buttonsDict = new Dictionary(true);
         _buttonsDict["BTN_ATTACK"] = getMovieClipByKey("outercity.menu.FightAsset");
         _buttonsDict["BTN_MOVE"] = getMovieClipByKey("outercity.menu.MoveToAsset");
         _buttonsDict["BTN_INFO"] = getMovieClipByKey("outercity.menu.InfoMAsset");
         _buttonsDict["BTN_ENTER"] = getMovieClipByKey("outercity.menu.InnerAsset");
         _buttonsDict["BTN_RETURN"] = getMovieClipByKey("outercity.menu.ReturnCastleAsset");
         _buttonsDict["BTN_CALL"] = getMovieClipByKey("outercity.menu.CallBackAsset");
         _buttonsDict["BTN_PORTAL"] = getMovieClipByKey("outercity.menu.ReturnCastleAsset");
         _buttonsDict["BTN_GIVE_UP"] = getMovieClipByKey("outercity.menu.GiveUpAsset");
         _buttonsDict["FRIEND"] = getMovieClipByKey("outercity.menu.FriendAsset");
         _buttonsDict["WRITE_EMAIL"] = getMovieClipByKey("outercity.menu.WriteEmailAsset");
         for(var _loc1_:String in _buttonsDict)
         {
            (_buttonsDict[_loc1_] as MovieImage).movie.id = _loc1_;
            (_buttonsDict[_loc1_] as MovieImage).movie.gotoAndStop(1);
            (_buttonsDict[_loc1_] as MovieImage).tipData = _buttonsName[_loc1_];
            (_buttonsDict[_loc1_] as MovieImage).tipGapH = -10;
            (_buttonsDict[_loc1_] as MovieImage).tipGapV = -10;
            (_buttonsDict[_loc1_] as MovieImage).isFollowMouse = false;
            (_buttonsDict[_loc1_] as MovieImage).tipDirctions = "4,0,5,1,2";
         }
         buttonsMouseEnabled = false;
         addEvnet();
      }
      
      private function getMovieClipByKey(param1:String) : MovieImage
      {
         return ComponentFactory.Instance.creatComponentByStylename(param1) as MovieImage;
      }
      
      private function getButtonsName() : void
      {
         _buttonsName = new Dictionary(true);
         _buttonsName["BTN_ATTACK"] = LanguageMgr.GetTranslation("public.attack1");
         _buttonsName["BTN_MOVE"] = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.MOVE");
         _buttonsName["BTN_INFO"] = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.INFO");
         _buttonsName["BTN_ENTER"] = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.ENTER");
         _buttonsName["BTN_RETURN"] = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.RETURN");
         _buttonsName["BTN_CALL"] = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.CALL");
         _buttonsName["BTN_PORTAL"] = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.PORTAL");
         _buttonsName["BTN_GIVE_UP"] = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.GIVE_UP");
         _buttonsName["FRIEND"] = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.addFriend");
         _buttonsName["WRITE_EMAIL"] = LanguageMgr.GetTranslation("map.internals.view.displaye.PhysicsMenu.EMAIL");
      }
      
      private function set buttonsMouseEnabled(param1:Boolean) : void
      {
         for each(var _loc2_:MovieImage in _buttonsDict)
         {
            _loc2_.mouseEnabled = param1;
         }
      }
      
      private function getTextfield(param1:String) : Object
      {
         var _loc2_:TextField = new TextField();
         _loc2_.textColor = 16777215;
         _loc2_.text = param1;
         _loc2_.width = _loc2_.textWidth + 5;
         _loc2_.height = _loc2_.textHeight + 5;
         return _loc2_;
      }
      
      private function addEvnet() : void
      {
         for each(var _loc1_:MovieImage in _buttonsDict)
         {
            _loc1_.buttonMode = true;
            _loc1_.addEventListener("click",__clickHandler);
            _loc1_.addEventListener("mouseOver",__mouseOverHandler);
            _loc1_.addEventListener("mouseOut",__mouseOutHandler);
         }
         addEventListener("addedToStage",__addStage);
         addEventListener("removedFromStage",__removeStage);
      }
      
      private function removeEvent() : void
      {
         for each(var _loc1_:MovieImage in _buttonsDict)
         {
            _loc1_.buttonMode = true;
            _loc1_.removeEventListener("click",__clickHandler);
            _loc1_.removeEventListener("mouseOver",__mouseOverHandler);
            _loc1_.removeEventListener("mouseOut",__mouseOutHandler);
         }
         removeEventListener("addedToStage",__addStage);
         removeEventListener("removedFromStage",__removeStage);
         StageReferance.stage.removeEventListener("mouseDown",__mouseDownHandler);
      }
      
      private function __addStage(param1:Event) : void
      {
         StageReferance.stage.addEventListener("mouseDown",__mouseDownHandler);
      }
      
      private function __removeStage(param1:Event) : void
      {
         StageReferance.stage.removeEventListener("mouseDown",__mouseDownHandler);
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         if(!this.hitTestPoint(param1.stageX,param1.stageY))
         {
            this.close();
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = (param1.currentTarget as MovieImage).movie.id;
         if(_callObj[_loc2_] != null)
         {
            _callObj[_loc2_]();
         }
         close();
         this.dispatchEvent(new MouseEvent("rollOut"));
         this.dispatchEvent(new PhysicsMenuEvent(_loc2_,null));
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         (param1.currentTarget as MovieImage).movie.gotoAndStop(2);
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         (param1.currentTarget as MovieImage).movie.gotoAndStop(1);
      }
      
      public function showPhysicsMenu(param1:MapPhysics, param2:Object = null) : void
      {
         _callObj = param2;
         var _loc3_:Point = _parent.localToGlobal(new Point(param1.x,param1.y));
         resetPhysicsView(param1,_loc3_);
         var _loc4_:Point = LayerManager.Instance.getLayerByType(2).globalToLocal(_loc3_);
         if(param1 is BaseCastle)
         {
            this.x = _loc4_.x - 25;
         }
         else
         {
            this.x = _loc4_.x - 25;
         }
         this.y = _loc4_.y - 40;
         LayerManager.Instance.addToLayer(this,3,false);
      }
      
      public function showArmyMenu(param1:BaseArmy, param2:Object, param3:Object = null) : void
      {
         var _loc4_:Point = null;
         _callObj = param2;
         if(param3)
         {
            _loc4_ = _parent.localToGlobal(new Point(param3.x,param3.y));
         }
         else
         {
            _loc4_ = _parent.localToGlobal(new Point(param1.curPosX * 20,param1.curPosY * 20));
         }
         resetArmyMenuView(param1,_loc4_);
         var _loc5_:Point = LayerManager.Instance.getLayerByType(3).globalToLocal(_loc4_);
         this.x = _loc5_.x - 15;
         this.y = _loc5_.y;
         LayerManager.Instance.addToLayer(this,3);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function set paretnContainer(param1:Sprite) : void
      {
         _parent = param1;
      }
      
      private function resetArmyMenuView(param1:BaseArmy, param2:Point) : void
      {
         var _loc3_:Number = NaN;
         while(vbox.numChildren > 0)
         {
            vbox.removeChildAt(0);
         }
         _loc3_ = directionPoint(param2,100);
         if(param1.userId == thane.userId)
         {
            if(thane.grades < 10)
            {
               moveOneButton("BTN_INFO",_loc3_,100);
            }
            else if(ArmyState.returnHome(param1.state))
            {
               moveTwoButtons("BTN_RETURN","BTN_INFO",_loc3_,100);
            }
            else
            {
               moveThreeButtons("BTN_CALL","BTN_RETURN","BTN_INFO",_loc3_,100);
            }
         }
         else
         {
            moveOneButton("BTN_INFO",_loc3_,100);
         }
         updateSelectArmyPos(param1);
      }
      
      private function resetPhysicsView(param1:MapPhysics, param2:Point) : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:BaseCastle = null;
         while(vbox.numChildren > 0)
         {
            vbox.removeChildAt(0);
         }
         if(param1 is BaseCastle)
         {
            _loc3_ = param1 as BaseCastle;
            _loc4_ = directionPoint(param2,100);
            if(_loc3_.info.occupyPlayerId == thane.userId)
            {
               moveOneButton("BTN_ENTER",_loc4_,100);
            }
            else if(_loc3_.info.occupyPlayerId == 0)
            {
               if(thane.grades >= 10)
               {
                  moveOneButton("BTN_PORTAL",_loc4_,80);
               }
            }
            else
            {
               moveThreeButtons("BTN_ATTACK","FRIEND","WRITE_EMAIL",_loc4_,100);
            }
         }
         else if(param1 is CampaignNode)
         {
            _loc4_ = directionPoint(param2,80);
            if(param1.info.state == 2 || !(param1.info.types == 41 || param1.info.types == 42))
            {
               moveOneButton("BTN_MOVE",_loc4_,100);
            }
            else
            {
               moveTwoButtons("BTN_ATTACK","BTN_INFO",_loc4_,100);
            }
         }
         else if((param1 as WildLand).info.occupyPlayerId == thane.userId)
         {
            _loc4_ = directionPoint(param2,80);
            moveOneButton("BTN_GIVE_UP",_loc4_,80);
         }
         else
         {
            _loc4_ = directionPoint(param2,80);
            moveOneButton("BTN_ATTACK",_loc4_,100);
         }
         updateSelectPhysicsPos(param1);
      }
      
      private function moveOneButton(param1:String, param2:Number, param3:int) : void
      {
         var _loc4_:MovieImage = initBtnMovie(param1);
         motionTo(_loc4_,param3 * param2,90);
      }
      
      private function moveTwoButtons(param1:String, param2:String, param3:Number, param4:int, param5:int = 10) : void
      {
         var _loc7_:MovieImage = initBtnMovie(param1);
         var _loc6_:MovieImage = initBtnMovie(param2);
         motionTo(_loc7_,param4 * param3,90 - param5 / param3);
         motionTo(_loc6_,param4 * param3,90 + param5 / param3);
      }
      
      private function moveThreeButtons(param1:String, param2:String, param3:String, param4:Number, param5:int) : void
      {
         var _loc8_:MovieImage = initBtnMovie(param1);
         var _loc6_:MovieImage = initBtnMovie(param2);
         var _loc7_:MovieImage = initBtnMovie(param3);
         motionTo(_loc8_,param5 * param4,90);
         motionTo(_loc6_,param5 * param4,90 - 30 / param4);
         motionTo(_loc7_,param5 * param4,90 + 30 / param4);
      }
      
      private function initBtnMovie(param1:String) : MovieImage
      {
         var _loc2_:MovieImage = _buttonsDict[param1] as MovieImage;
         _loc2_.x = _loc2_.y = 0;
         _loc2_.movie.gotoAndStop(1);
         vbox.addChild(_loc2_);
         return _loc2_;
      }
      
      private function motionTo(param1:MovieImage, param2:Number, param3:Number) : void
      {
         param1.alpha = 0;
         var _loc5_:Number = param1.x - param2 * Math.cos(param3 * 3.141592653589793 / 180);
         var _loc4_:Number = param1.y + param2 * Math.sin(param3 * 3.141592653589793 / 180);
         TweenLite.to(param1,0.2,{
            "x":_loc5_,
            "y":_loc4_,
            "alpha":1,
            "onComplete":tweenComplete
         });
      }
      
      private function tweenComplete() : void
      {
         buttonsMouseEnabled = true;
      }
      
      private function directionPoint(param1:Point, param2:Number) : Number
      {
         return StageReferance.stageHeight - param1.y < param2 ? -1.3 : 1;
      }
      
      private function createSelectEffect() : void
      {
         _selectEffct = new MovieClip();
         _selectEffct.stop();
         _selectEffct.scrollRect = null;
         _selectEffct.mouseChildren = _selectEffct.mouseEnabled = false;
         _selectEffct.visible = false;
      }
      
      private function updateSelectPhysicsPos(param1:MapPhysics) : void
      {
         if(param1 is BaseCastle)
         {
            if(param1.info.occupyPlayerId == 0)
            {
               _selectEffct.gotoAndStop(2);
               _selectEffct.x = param1.posX * 20 - _selectEffct.width / 2;
               _selectEffct.y = param1.posY * 20 - _selectEffct.height / 2;
            }
            else
            {
               _selectEffct.gotoAndStop(1);
               _selectEffct.x = param1.posX * 20 - _selectEffct.width / 2 + 6;
               _selectEffct.y = param1.posY * 20 - _selectEffct.height / 2 + 20;
            }
            _selectEffct.visible = true;
         }
         else if(param1 is CampaignNode)
         {
            _selectEffct.gotoAndStop(3);
            _selectEffct.x = param1.posX * 20 + 6;
            _selectEffct.y = param1.posY * 20 + 20;
            _selectEffct.visible = true;
         }
         else
         {
            _selectEffct.gotoAndStop(3);
            if(param1 is WildLand && param1.info.types == 22 || param1.info.types == 20)
            {
               _selectEffct.x = param1.posX * 20 + 7;
               _selectEffct.y = param1.posY * 20 + 5;
            }
            else
            {
               _selectEffct.x = param1.posX * 20 + 6;
               _selectEffct.y = param1.posY * 20 + 20;
            }
            _selectEffct.visible = true;
         }
         if(_selectEffct.visible)
         {
            _parent.addChildAt(_selectEffct,0);
         }
      }
      
      private function updateSelectArmyPos(param1:BaseArmy) : void
      {
         _selectEffct.gotoAndStop(3);
         _selectEffct.x = param1.curPosX * 20 + 6;
         _selectEffct.y = param1.curPosY * 20 + 20;
         _selectEffct.visible = true;
         if(_selectEffct.visible)
         {
            _parent.addChildAt(_selectEffct,0);
         }
      }
      
      public function close() : void
      {
         if(_selectEffct)
         {
            _selectEffct.visible = false;
         }
         buttonsMouseEnabled = false;
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_selectEffct)
         {
            if(_selectEffct.parent)
            {
               _selectEffct.parent.removeChild(_selectEffct);
            }
            _selectEffct.stop();
         }
         _selectEffct = null;
         for each(var _loc1_:MovieImage in _buttonsDict)
         {
            _loc1_.movie.stop();
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc1_.dispose();
            _loc1_ = null;
         }
         _buttonsDict = null;
         _buttonsName = null;
         _instance = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

