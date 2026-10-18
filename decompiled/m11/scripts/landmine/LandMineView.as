package landmine
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import events.LandMineEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import landmine.mediator.LandMineCursorMediator;
   import landmine.mediator.LandMineDragMediator;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import mvc.module.gamehall.GameHallGameInfo;
   import mvc.module.gamehall.GameHallModel;
   import mvc.module.landmine.LandMineModel;
   import mvc.module.landmine.LandMineSapperInfo;
   import utils.GuideUtils;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.LandMineManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class LandMineView extends Sprite implements Disposeable
   {
      
      public static const FLAG_NUM:int = 10000;
      
      public static const NAME:String = "landmine.LandMineView";
      
      private var _platformLayer:Sprite;
      
      private var _heroLayer:Sprite;
      
      private var _effectLayer:Sprite;
      
      private var _bg:Image;
      
      private var _castleBtnStart:BaseButton;
      
      private var _castleBtnEnd:BaseButton;
      
      private var _stoneBtn00:BaseButton;
      
      private var _stoneBtn01:BaseButton;
      
      private var _stoneBtn02:BaseButton;
      
      private var _stoneBtn03:BaseButton;
      
      private var _stoneBtn10:BaseButton;
      
      private var _stoneBtn11:BaseButton;
      
      private var _stoneBtn12:BaseButton;
      
      private var _stoneBtn13:BaseButton;
      
      private var _stoneBtn20:BaseButton;
      
      private var _stoneBtn21:BaseButton;
      
      private var _stoneBtn22:BaseButton;
      
      private var _stoneBtn23:BaseButton;
      
      private var _stoneBtn30:BaseButton;
      
      private var _stoneBtn31:BaseButton;
      
      private var _stoneBtn32:BaseButton;
      
      private var _stoneBtn33:BaseButton;
      
      private var _stoneBtn40:BaseButton;
      
      private var _stoneBtn41:BaseButton;
      
      private var _stoneBtn42:BaseButton;
      
      private var _stoneBtn43:BaseButton;
      
      private var _stoneGroupList1:Vector.<BaseButton>;
      
      private var _stoneGroupList2:Vector.<BaseButton>;
      
      private var _stoneGroupList3:Vector.<BaseButton>;
      
      private var _stoneGroupList4:Vector.<BaseButton>;
      
      private var _stoneGroupList5:Vector.<BaseButton>;
      
      private var _heroView1:LandMineHeroView;
      
      private var _heroView2:LandMineHeroView;
      
      private var _heroView3:LandMineHeroView;
      
      private var _heroView4:LandMineHeroView;
      
      private var _heroViewList:Vector.<LandMineHeroView>;
      
      private var _stoneToIndexDic:Dictionary = new Dictionary(true);
      
      private var _btnToPosDic:Dictionary = new Dictionary(true);
      
      private var _isDied:Boolean = false;
      
      private var _gameEndFlag:Boolean = false;
      
      private var _gameEndCallBack:Function;
      
      public var isDraging:Boolean = false;
      
      private var _mediatorKey:String;
      
      private var _gameHallModel:GameHallModel = GameHallManager.instance.model;
      
      private var _model:LandMineModel = LandMineManager.instance.model;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var mouseIsMove:Boolean;
      
      private var _timeId:int = 0;
      
      private var lastXY:int = -1;
      
      private var _intervalTime:Number = 0;
      
      public const startX:int = 0;
      
      public const startY:int = 0;
      
      public function LandMineView(param1:Function)
      {
         _gameEndCallBack = param1;
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function randRange(param1:Number, param2:Number) : Number
      {
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      public function test() : void
      {
         var _loc7_:LandMineSapperInfo = null;
         var _loc2_:LandMineHeroView = null;
         var _loc5_:Array = [];
         var _loc1_:Array = [];
         var _loc6_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = 50;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc7_ = new LandMineSapperInfo();
            _loc7_.index = randRange(1,4);
            _loc7_.posX = randRange(0,4);
            _loc7_.posY = randRange(0,3);
            _loc7_.state = 0;
            buildSapperInfo(_loc7_,_loc7_.index);
            _loc5_.push(_loc7_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc7_ = _loc5_[_loc4_] as LandMineSapperInfo;
            if(_loc7_ != null)
            {
               _loc2_ = _heroViewList[_loc7_.index - 1];
               if(_loc2_)
               {
                  _loc2_.action(_loc7_);
               }
            }
            _loc4_++;
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.frameBg");
         _platformLayer = new Sprite();
         _heroLayer = new Sprite();
         _effectLayer = new Sprite();
         _platformLayer.y = _heroLayer.y = _effectLayer.y = 100;
         initPlatform();
         initHero();
         initEffect();
         addChild(_bg);
         addChild(_platformLayer);
         addChild(_heroLayer);
         addChild(_effectLayer);
      }
      
      private function initPlatform() : void
      {
         _castleBtnStart = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.castleBtnStart");
         _castleBtnEnd = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.castleBtnEnd");
         _stoneBtn00 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn00");
         _stoneBtn01 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn01");
         _stoneBtn02 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn02");
         _stoneBtn03 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn03");
         _stoneBtn10 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn10");
         _stoneBtn11 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn11");
         _stoneBtn12 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn12");
         _stoneBtn13 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn13");
         _stoneBtn20 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn20");
         _stoneBtn21 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn21");
         _stoneBtn22 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn22");
         _stoneBtn23 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn23");
         _stoneBtn30 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn30");
         _stoneBtn31 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn31");
         _stoneBtn32 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn32");
         _stoneBtn33 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn33");
         _stoneBtn40 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn40");
         _stoneBtn41 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn41");
         _stoneBtn42 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn42");
         _stoneBtn43 = ComponentFactory.Instance.creatComponentByStylename("landmine.LandMineView.stoneBtn43");
         initStoneGroup();
         initBtnPosition();
         _platformLayer.addChild(_castleBtnStart);
         _platformLayer.addChild(_castleBtnEnd);
         _platformLayer.addChild(_stoneBtn00);
         _platformLayer.addChild(_stoneBtn01);
         _platformLayer.addChild(_stoneBtn02);
         _platformLayer.addChild(_stoneBtn03);
         _platformLayer.addChild(_stoneBtn10);
         _platformLayer.addChild(_stoneBtn11);
         _platformLayer.addChild(_stoneBtn12);
         _platformLayer.addChild(_stoneBtn13);
         _platformLayer.addChild(_stoneBtn20);
         _platformLayer.addChild(_stoneBtn21);
         _platformLayer.addChild(_stoneBtn22);
         _platformLayer.addChild(_stoneBtn23);
         _platformLayer.addChild(_stoneBtn30);
         _platformLayer.addChild(_stoneBtn31);
         _platformLayer.addChild(_stoneBtn32);
         _platformLayer.addChild(_stoneBtn33);
         _platformLayer.addChild(_stoneBtn40);
         _platformLayer.addChild(_stoneBtn41);
         _platformLayer.addChild(_stoneBtn42);
         _platformLayer.addChild(_stoneBtn43);
      }
      
      private function initHero() : void
      {
         _heroView1 = new LandMineHeroView(actionCallBack,moveEffectCallBack,trapEffectCallBack);
         _heroView2 = new LandMineHeroView(actionCallBack,moveEffectCallBack,trapEffectCallBack);
         _heroView3 = new LandMineHeroView(actionCallBack,moveEffectCallBack,trapEffectCallBack);
         _heroView4 = new LandMineHeroView(actionCallBack,moveEffectCallBack,trapEffectCallBack);
         _heroView1.visible = false;
         _heroView2.visible = false;
         _heroView3.visible = false;
         _heroView4.visible = false;
         setHeroViewPosition(_heroView1,_castleBtnStart,1);
         setHeroViewPosition(_heroView2,_castleBtnStart,2);
         setHeroViewPosition(_heroView3,_castleBtnStart,3);
         setHeroViewPosition(_heroView4,_castleBtnStart,4);
         _heroViewList = new Vector.<LandMineHeroView>();
         _heroViewList.push(_heroView1);
         _heroViewList.push(_heroView2);
         _heroViewList.push(_heroView3);
         _heroViewList.push(_heroView4);
         _heroLayer.addChild(_heroView1);
         _heroLayer.addChild(_heroView2);
         _heroLayer.addChild(_heroView3);
         _heroLayer.addChild(_heroView4);
         _heroLayer.mouseEnabled = _heroLayer.mouseChildren = false;
      }
      
      private function initEffect() : void
      {
         _effectLayer.addChild(_heroView1.moveEffectView);
         _effectLayer.addChild(_heroView2.moveEffectView);
         _effectLayer.addChild(_heroView3.moveEffectView);
         _effectLayer.addChild(_heroView4.moveEffectView);
         _effectLayer.addChild(_heroView1.trapEffectView);
         _effectLayer.addChild(_heroView2.trapEffectView);
         _effectLayer.addChild(_heroView3.trapEffectView);
         _effectLayer.addChild(_heroView4.trapEffectView);
         _effectLayer.mouseEnabled = _effectLayer.mouseChildren = false;
      }
      
      private function initStoneGroup() : void
      {
         _stoneGroupList1 = new Vector.<BaseButton>();
         _stoneGroupList1.push(_stoneBtn00);
         _stoneGroupList1.push(_stoneBtn01);
         _stoneGroupList1.push(_stoneBtn02);
         _stoneGroupList1.push(_stoneBtn03);
         _stoneToIndexDic[_stoneBtn00] = 0;
         _stoneToIndexDic[_stoneBtn01] = 1;
         _stoneToIndexDic[_stoneBtn02] = 2;
         _stoneToIndexDic[_stoneBtn03] = 3;
         _stoneGroupList2 = new Vector.<BaseButton>();
         _stoneGroupList2.push(_stoneBtn10);
         _stoneGroupList2.push(_stoneBtn11);
         _stoneGroupList2.push(_stoneBtn12);
         _stoneGroupList2.push(_stoneBtn13);
         _stoneToIndexDic[_stoneBtn10] = 0;
         _stoneToIndexDic[_stoneBtn11] = 1;
         _stoneToIndexDic[_stoneBtn12] = 2;
         _stoneToIndexDic[_stoneBtn13] = 3;
         _stoneGroupList3 = new Vector.<BaseButton>();
         _stoneGroupList3.push(_stoneBtn20);
         _stoneGroupList3.push(_stoneBtn21);
         _stoneGroupList3.push(_stoneBtn22);
         _stoneGroupList3.push(_stoneBtn23);
         _stoneToIndexDic[_stoneBtn20] = 0;
         _stoneToIndexDic[_stoneBtn21] = 1;
         _stoneToIndexDic[_stoneBtn22] = 2;
         _stoneToIndexDic[_stoneBtn23] = 3;
         _stoneGroupList4 = new Vector.<BaseButton>();
         _stoneGroupList4.push(_stoneBtn30);
         _stoneGroupList4.push(_stoneBtn31);
         _stoneGroupList4.push(_stoneBtn32);
         _stoneGroupList4.push(_stoneBtn33);
         _stoneToIndexDic[_stoneBtn30] = 0;
         _stoneToIndexDic[_stoneBtn31] = 1;
         _stoneToIndexDic[_stoneBtn32] = 2;
         _stoneToIndexDic[_stoneBtn33] = 3;
         _stoneGroupList5 = new Vector.<BaseButton>();
         _stoneGroupList5.push(_stoneBtn40);
         _stoneGroupList5.push(_stoneBtn41);
         _stoneGroupList5.push(_stoneBtn42);
         _stoneGroupList5.push(_stoneBtn43);
         _stoneToIndexDic[_stoneBtn40] = 0;
         _stoneToIndexDic[_stoneBtn41] = 1;
         _stoneToIndexDic[_stoneBtn42] = 2;
         _stoneToIndexDic[_stoneBtn43] = 3;
      }
      
      private function initBtnPosition() : void
      {
         _btnToPosDic[_castleBtnStart] = new Point(100,145);
         _btnToPosDic[_castleBtnEnd] = new Point(100,145);
         _btnToPosDic[_stoneBtn00] = new Point(40,50);
         _btnToPosDic[_stoneBtn01] = new Point(40,50);
         _btnToPosDic[_stoneBtn02] = new Point(40,50);
         _btnToPosDic[_stoneBtn03] = new Point(50,40);
         _btnToPosDic[_stoneBtn10] = new Point(50,40);
         _btnToPosDic[_stoneBtn11] = new Point(50,30);
         _btnToPosDic[_stoneBtn12] = new Point(50,40);
         _btnToPosDic[_stoneBtn13] = new Point(50,40);
         _btnToPosDic[_stoneBtn20] = new Point(50,40);
         _btnToPosDic[_stoneBtn21] = new Point(50,40);
         _btnToPosDic[_stoneBtn22] = new Point(50,40);
         _btnToPosDic[_stoneBtn23] = new Point(50,40);
         _btnToPosDic[_stoneBtn30] = new Point(50,40);
         _btnToPosDic[_stoneBtn31] = new Point(60,20);
         _btnToPosDic[_stoneBtn32] = new Point(30,50);
         _btnToPosDic[_stoneBtn33] = new Point(60,20);
         _btnToPosDic[_stoneBtn40] = new Point(60,30);
         _btnToPosDic[_stoneBtn41] = new Point(50,40);
         _btnToPosDic[_stoneBtn42] = new Point(40,40);
         _btnToPosDic[_stoneBtn43] = new Point(40,50);
      }
      
      private function enableGroupList(param1:Vector.<BaseButton>, param2:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            param1[_loc4_].enable = param2;
            _loc4_++;
         }
      }
      
      private function flashGroupList(param1:Vector.<BaseButton>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            GuideUtils.flash(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      private function stopFlashGroupList(param1:Vector.<BaseButton>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            GuideUtils.stopFlash(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      private function setHeroViewPosition(param1:LandMineHeroView, param2:BaseButton, param3:int) : void
      {
         var _loc4_:Point = getPositionShift(getPosition(param2),param3);
         param1.x = _loc4_.x;
         param1.y = _loc4_.y;
      }
      
      private function getPosition(param1:BaseButton) : Point
      {
         var _loc2_:Point = new Point();
         _loc2_.x = param1.x + _btnToPosDic[param1].x;
         _loc2_.y = param1.y + _btnToPosDic[param1].y;
         return _loc2_;
      }
      
      private function getPositionShift(param1:Point, param2:int) : Point
      {
         var _loc3_:Point = new Point(param1.x,param1.y);
         switch(param2 - 1)
         {
            case 0:
               _loc3_.x -= 25;
               _loc3_.y -= 25;
               break;
            case 1:
               _loc3_.x += 25;
               _loc3_.y -= 25;
               break;
            case 2:
               _loc3_.x -= 15;
               _loc3_.y += 25;
               break;
            case 3:
               _loc3_.x += 35;
               _loc3_.y += 25;
         }
         return _loc3_;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_castleBtnStart);
         _castleBtnStart = null;
         ObjectUtils.disposeObject(_castleBtnEnd);
         _castleBtnEnd = null;
         ObjectUtils.disposeObject(_stoneBtn00);
         _stoneBtn00 = null;
         ObjectUtils.disposeObject(_stoneBtn01);
         _stoneBtn01 = null;
         ObjectUtils.disposeObject(_stoneBtn02);
         _stoneBtn02 = null;
         ObjectUtils.disposeObject(_stoneBtn03);
         _stoneBtn03 = null;
         ObjectUtils.disposeObject(_stoneBtn10);
         _stoneBtn10 = null;
         ObjectUtils.disposeObject(_stoneBtn11);
         _stoneBtn11 = null;
         ObjectUtils.disposeObject(_stoneBtn12);
         _stoneBtn12 = null;
         ObjectUtils.disposeObject(_stoneBtn13);
         _stoneBtn13 = null;
         ObjectUtils.disposeObject(_stoneBtn20);
         _stoneBtn20 = null;
         ObjectUtils.disposeObject(_stoneBtn21);
         _stoneBtn21 = null;
         ObjectUtils.disposeObject(_stoneBtn22);
         _stoneBtn22 = null;
         ObjectUtils.disposeObject(_stoneBtn23);
         _stoneBtn23 = null;
         ObjectUtils.disposeObject(_stoneBtn30);
         _stoneBtn30 = null;
         ObjectUtils.disposeObject(_stoneBtn31);
         _stoneBtn31 = null;
         ObjectUtils.disposeObject(_stoneBtn32);
         _stoneBtn32 = null;
         ObjectUtils.disposeObject(_stoneBtn33);
         _stoneBtn33 = null;
         ObjectUtils.disposeObject(_stoneBtn40);
         _stoneBtn40 = null;
         ObjectUtils.disposeObject(_stoneBtn41);
         _stoneBtn41 = null;
         ObjectUtils.disposeObject(_stoneBtn42);
         _stoneBtn42 = null;
         ObjectUtils.disposeObject(_stoneBtn43);
         _stoneBtn43 = null;
         ObjectUtils.disposeObject(_heroView1);
         _heroView1 = null;
         ObjectUtils.disposeObject(_heroView2);
         _heroView2 = null;
         ObjectUtils.disposeObject(_heroView3);
         _heroView3 = null;
         ObjectUtils.disposeObject(_heroView4);
         _heroView4 = null;
         ObjectUtils.disposeObject(_effectLayer);
         _effectLayer = null;
         ObjectUtils.disposeObject(_heroLayer);
         _heroLayer = null;
         ObjectUtils.disposeObject(_platformLayer);
         _platformLayer = null;
         LogicUtils.disposeDisplayCollection(_heroViewList);
         _heroViewList = null;
         LogicUtils.disposeDisplayCollection(_stoneGroupList1);
         _stoneGroupList1 = null;
         LogicUtils.disposeDisplayCollection(_stoneGroupList2);
         _stoneGroupList2 = null;
         LogicUtils.disposeDisplayCollection(_stoneGroupList3);
         _stoneGroupList3 = null;
         LogicUtils.disposeDisplayCollection(_stoneGroupList4);
         _stoneGroupList4 = null;
         LogicUtils.disposeDisplayCollection(_stoneGroupList5);
         _stoneGroupList5 = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         _castleBtnEnd.addEventListener("click",__btnClickHandler);
         _stoneBtn00.addEventListener("click",__btnClickHandler);
         _stoneBtn01.addEventListener("click",__btnClickHandler);
         _stoneBtn02.addEventListener("click",__btnClickHandler);
         _stoneBtn03.addEventListener("click",__btnClickHandler);
         _stoneBtn10.addEventListener("click",__btnClickHandler);
         _stoneBtn11.addEventListener("click",__btnClickHandler);
         _stoneBtn12.addEventListener("click",__btnClickHandler);
         _stoneBtn13.addEventListener("click",__btnClickHandler);
         _stoneBtn20.addEventListener("click",__btnClickHandler);
         _stoneBtn21.addEventListener("click",__btnClickHandler);
         _stoneBtn22.addEventListener("click",__btnClickHandler);
         _stoneBtn23.addEventListener("click",__btnClickHandler);
         _stoneBtn30.addEventListener("click",__btnClickHandler);
         _stoneBtn31.addEventListener("click",__btnClickHandler);
         _stoneBtn32.addEventListener("click",__btnClickHandler);
         _stoneBtn33.addEventListener("click",__btnClickHandler);
         _stoneBtn40.addEventListener("click",__btnClickHandler);
         _stoneBtn41.addEventListener("click",__btnClickHandler);
         _stoneBtn42.addEventListener("click",__btnClickHandler);
         _stoneBtn43.addEventListener("click",__btnClickHandler);
         _model.addEventListener("SAPPER_LEAVE",__sapperLeaveHandler);
         _model.addEventListener("SAPPER_MOVE",__sapperMoveHandler);
         _model.addEventListener("GAME_END",__gameEndHandler);
         this.addEventListener("mouseDown",__mouseDownHandler);
         this.addEventListener("addedToStage",__addStageHandler);
      }
      
      private function removeEvent() : void
      {
         _castleBtnEnd.removeEventListener("click",__btnClickHandler);
         _stoneBtn00.removeEventListener("click",__btnClickHandler);
         _stoneBtn01.removeEventListener("click",__btnClickHandler);
         _stoneBtn02.removeEventListener("click",__btnClickHandler);
         _stoneBtn03.removeEventListener("click",__btnClickHandler);
         _stoneBtn10.removeEventListener("click",__btnClickHandler);
         _stoneBtn11.removeEventListener("click",__btnClickHandler);
         _stoneBtn12.removeEventListener("click",__btnClickHandler);
         _stoneBtn13.removeEventListener("click",__btnClickHandler);
         _stoneBtn20.removeEventListener("click",__btnClickHandler);
         _stoneBtn21.removeEventListener("click",__btnClickHandler);
         _stoneBtn22.removeEventListener("click",__btnClickHandler);
         _stoneBtn23.removeEventListener("click",__btnClickHandler);
         _stoneBtn30.removeEventListener("click",__btnClickHandler);
         _stoneBtn31.removeEventListener("click",__btnClickHandler);
         _stoneBtn32.removeEventListener("click",__btnClickHandler);
         _stoneBtn33.removeEventListener("click",__btnClickHandler);
         _stoneBtn40.removeEventListener("click",__btnClickHandler);
         _stoneBtn41.removeEventListener("click",__btnClickHandler);
         _stoneBtn42.removeEventListener("click",__btnClickHandler);
         _stoneBtn43.removeEventListener("click",__btnClickHandler);
         _model.removeEventListener("SAPPER_LEAVE",__sapperLeaveHandler);
         _model.removeEventListener("SAPPER_MOVE",__sapperMoveHandler);
         _model.removeEventListener("GAME_END",__gameEndHandler);
         this.removeEventListener("mouseDown",__mouseDownHandler);
         this.removeEventListener("addedToStage",__addStageHandler);
      }
      
      private function __addStageHandler(param1:Event) : void
      {
         var _loc2_:Array = [LandMineDragMediator,LandMineCursorMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc2_,this,"landmine.LandMineView");
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         this.addEventListener("mouseMove",onMouseMove);
         this.addEventListener("mouseUp",onMouseUp);
         mouseIsMove = false;
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         mouseIsMove = true;
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         this.removeEventListener("mouseMove",onMouseMove);
         this.removeEventListener("mouseUp",onMouseUp);
         if(mouseIsMove)
         {
            return;
         }
      }
      
      private function __gameEndHandler(param1:LandMineEvent) : void
      {
         var _loc4_:LandMineSapperInfo = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:LandMineHeroView = null;
         var _loc6_:BaseButton = null;
         var _loc7_:int = 0;
         if(_model.isWin)
         {
            _loc4_ = new LandMineSapperInfo();
            _loc3_ = int(_heroViewList.length);
            _loc5_ = 0;
            _loc6_ = _castleBtnEnd;
            _loc4_.userId = _model.winnerId;
            _loc4_.state = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc2_ = _heroViewList[_loc7_];
               _loc5_ = _loc7_ + 1;
               if(_loc2_ && _loc2_.data && _loc6_ && _loc2_.data.userId == _loc4_.userId)
               {
                  buildSapperInfo(_loc4_,_loc5_,_loc6_);
                  _loc2_.action(_loc4_);
                  break;
               }
               _loc7_++;
            }
            checkBtnState(_loc4_);
         }
         _gameEndFlag = true;
         gameEndCheck();
      }
      
      private function __sapperMoveHandler(param1:LandMineEvent) : void
      {
         var _loc2_:LandMineHeroView = null;
         var _loc6_:BaseButton = null;
         var _loc7_:int = 0;
         var _loc4_:LandMineSapperInfo = param1.data as LandMineSapperInfo;
         var _loc3_:int = int(_heroViewList.length);
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         if(_loc4_)
         {
            _loc8_ = _loc4_.posX + 1;
            _loc6_ = this["_stoneGroupList" + _loc8_][_loc4_.posY];
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc2_ = _heroViewList[_loc7_];
               _loc5_ = _loc7_ + 1;
               if(_loc2_ && _loc2_.data && _loc6_ && _loc2_.data.userId == _loc4_.userId)
               {
                  buildSapperInfo(_loc4_,_loc5_,_loc6_);
                  _loc2_.action(_loc4_);
                  break;
               }
               _loc7_++;
            }
            checkBtnState(_loc4_);
         }
      }
      
      private function checkBtnState(param1:LandMineSapperInfo) : void
      {
         if(isSelfSapperInfo(param1))
         {
            resetBtnState();
            if(param1.state == 1)
            {
               _isDied = true;
            }
         }
      }
      
      private function buildSapperInfo(param1:LandMineSapperInfo, param2:int = 0, param3:BaseButton = null) : void
      {
         var _loc4_:int = 0;
         if(param3 == null)
         {
            _loc4_ = param1.posX + 1;
            param3 = this["_stoneGroupList" + _loc4_][param1.posY];
         }
         param1.index = param2;
         param1.centerPosition = getPosition(param3);
         param1.targetPosition = getPositionShift(param1.centerPosition,param1.index);
      }
      
      private function actionCallBack() : void
      {
      }
      
      private function moveEffectCallBack(param1:LandMineSapperInfo) : void
      {
         if(_model.isWin || isSelfSapperInfo(param1))
         {
            gameEndCheck(param1);
         }
      }
      
      private function trapEffectCallBack(param1:LandMineSapperInfo) : void
      {
         if(isSelfSapperInfo(param1))
         {
            showTips();
         }
         gameEndCheck(param1);
      }
      
      private function heroAllStop() : Boolean
      {
         var _loc2_:LandMineHeroView = null;
         var _loc4_:int = 0;
         var _loc1_:Boolean = true;
         var _loc3_:int = int(_heroViewList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _heroViewList[_loc4_];
            if(_loc2_.data && _model.sapperDic[_loc2_.data.userId] && _loc2_.actionFlag)
            {
               _loc1_ = false;
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      private function heroVictory() : void
      {
         var _loc1_:LandMineHeroView = null;
         var _loc3_:int = 0;
         var _loc2_:int = int(_heroViewList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _heroViewList[_loc3_];
            if(_loc1_.data && _model.sapperDic[_loc1_.data.userId])
            {
               _loc1_.visible = true;
               _loc1_.heroMovie.gotoAndPlay("Victory");
            }
            _loc3_++;
         }
      }
      
      private function gameEndCheck(param1:LandMineSapperInfo = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:GameHallGameInfo = null;
         if(_gameEndFlag)
         {
            if(heroAllStop())
            {
               if(_model.isWin)
               {
                  heroVictory();
                  _loc3_ = new GameHallGameInfo();
                  _loc3_.gameId = 2;
                  if(_gameHallModel.hasEarnings)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("landmine.LandMineView.TipsTxt02");
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("landmine.LandMineView.TipsTxt04");
                  }
               }
               else
               {
                  _loc2_ = LanguageMgr.GetTranslation("landmine.LandMineView.TipsTxt03");
               }
               _timeId = setTimeout(gameEndCallBack,3000,_loc2_);
               MessageTipManager.instance().show(_loc2_);
            }
         }
         else if(isSelfSapperInfo(param1))
         {
            refreshBtnState();
         }
      }
      
      private function isSelfSapperInfo(param1:LandMineSapperInfo) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1 && param1.userId == _playerInfo.userId)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function gameEndCallBack(param1:String) : void
      {
         if(_gameEndCallBack != null)
         {
            _gameEndCallBack();
         }
      }
      
      private function showTips() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("landmine.LandMineView.TipsTxt01");
         MessageTipManager.instance().show(_loc1_);
      }
      
      private function __sapperLeaveHandler(param1:LandMineEvent) : void
      {
         var _loc2_:LandMineHeroView = null;
         var _loc5_:int = 0;
         var _loc4_:LandMineSapperInfo = param1.data as LandMineSapperInfo;
         var _loc3_:int = int(_heroViewList.length);
         if(_loc4_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc2_ = _heroViewList[_loc5_];
               if(_loc2_ && _loc2_.data && _loc2_.data.userId == _loc4_.userId)
               {
                  _loc2_.visible = false;
                  _model.sapperDic.del(_loc4_.userId);
               }
               _loc5_++;
            }
         }
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:BaseButton = param1.target as BaseButton;
         var _loc2_:int = 0;
         if(_loc3_ == _castleBtnEnd)
         {
            LandMineManager.instance.end();
         }
         else
         {
            _loc2_ = int(_stoneToIndexDic[_loc3_]);
            LandMineManager.instance.move(_loc2_);
         }
      }
      
      public function onDraging() : void
      {
         isDraging = true;
         if(lastXY != this.x * 10000 + this.y)
         {
            if(getTimer() - _intervalTime < 500)
            {
               return;
            }
            _intervalTime = getTimer();
            lastXY = this.x * 10000 + this.y;
         }
      }
      
      public function dragOver() : void
      {
         isDraging = false;
         if(lastXY != this.x * 10000 + this.y)
         {
            lastXY = this.x * 10000 + this.y;
         }
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      public function dragMoveCheck(param1:Point) : Point
      {
         var _loc2_:int = (StageReferance.stageWidth - this.width) / 2;
         var _loc3_:int = (StageReferance.stageHeight - this.height) / 2;
         if(_loc2_ >= 0)
         {
            param1.x = _loc2_;
         }
         else if(param1.x > 0)
         {
            param1.x = 0;
         }
         else if(param1.x <= StageReferance.stageWidth - this.width)
         {
            param1.x = StageReferance.stageWidth - this.width;
         }
         if(_loc3_ >= 0)
         {
            param1.y = _loc3_;
         }
         else if(param1.y > 0)
         {
            param1.y = 0;
         }
         else if(param1.y <= StageReferance.stageHeight - this.height)
         {
            param1.y = StageReferance.stageHeight - this.height;
         }
         return param1;
      }
      
      private function resetBtnState() : void
      {
         enableGroupList(_stoneGroupList1,false);
         enableGroupList(_stoneGroupList2,false);
         enableGroupList(_stoneGroupList3,false);
         enableGroupList(_stoneGroupList4,false);
         enableGroupList(_stoneGroupList5,false);
         _castleBtnEnd.enable = false;
         stopFlashGroupList(_stoneGroupList1);
         stopFlashGroupList(_stoneGroupList2);
         stopFlashGroupList(_stoneGroupList3);
         stopFlashGroupList(_stoneGroupList4);
         stopFlashGroupList(_stoneGroupList5);
         GuideUtils.stopFlash(_castleBtnEnd);
      }
      
      private function refreshBtnState() : void
      {
         var _loc1_:int = 0;
         if(!_isDied)
         {
            _loc1_ = _model.posX + 2;
            if(_loc1_ == 6)
            {
               _castleBtnEnd.enable = true;
               GuideUtils.flash(_castleBtnEnd);
            }
            else
            {
               enableGroupList(this["_stoneGroupList" + _loc1_],true);
               flashGroupList(this["_stoneGroupList" + _loc1_]);
            }
         }
      }
      
      private function refreshView() : void
      {
         var _loc4_:LandMineSapperInfo = null;
         var _loc1_:LandMineHeroView = null;
         var _loc5_:int = 0;
         resetBtnState();
         refreshBtnState();
         var _loc2_:Array = _model.sapperDic.getList();
         var _loc3_:int = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_[_loc5_];
            _loc1_ = _heroViewList[_loc5_];
            _loc1_.data = _loc4_;
            _loc1_.visible = true;
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = 0;
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         uninitView();
      }
   }
}

