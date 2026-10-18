package yishi.datas.objects
{
   import battle.BattleManager;
   import battle.actions.DannyAction;
   import battle.data.BloodUpdateVO;
   import battle.data.BufferDamageData;
   import battle.data.ReliveInfo;
   import battle.logsys.BattleLogSystem;
   import battle.queue.BattleActionQueue;
   import battle.queue.RoleSkillQueue;
   import battle.utils.BattleUtils;
   import battle.view.roles.RoleViewBase;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import yishi.datas.BattleModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.events.RoleEvent;
   import yishi.interfaces.IAction;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.tools.ActionMovie;
   
   public class RoleInfo extends EventDispatcher
   {
      
      public static const POS_HEAD:int = 1;
      
      public static const POS_BODY:int = 2;
      
      public static const POS_LEG:int = 3;
      
      private static const BLOOD_UPDATE_CD:int = 2;
      
      public var livingId:int;
      
      protected var _defaultAction:String;
      
      public var affectedSkill:IAction;
      
      private var _attackMode:int;
      
      public var effectId:String;
      
      private var _action:String;
      
      protected var _point:Point = new Point();
      
      private var _isLiving:Boolean = true;
      
      private var _side:int;
      
      private var _setVisible:Boolean;
      
      private var _pointZ:Number = 0;
      
      private var _scaleX:Number = 1;
      
      public var needShow:Boolean = false;
      
      public var showShadow:Boolean = false;
      
      public var pos:int;
      
      public var lineUp:int;
      
      private var _face:uint;
      
      private var _direction:String = "right";
      
      private var _isLoadComplete:Boolean = false;
      
      private var _currentBlood:Number = 0;
      
      public var canTakeDamage:Boolean = true;
      
      public var battleServerName:String;
      
      protected var _templateId:int;
      
      private var _baseBlood:int;
      
      private var _bloodCalculate:Number;
      
      public var dying:Boolean;
      
      public var multiLordsInspireLevel:int;
      
      private var _specialPosHead:Point;
      
      private var _specialPosBody:Point;
      
      private var _specialPosLeg:Point;
      
      public var coldDownTime:Number;
      
      public var coldDownFrame:int = -1;
      
      private var _restricted:Boolean;
      
      private var _moving:Boolean;
      
      public var readyFlag:Boolean = false;
      
      private var _bloodA:Number = 0;
      
      private var _isGoddess:Boolean;
      
      private var _belief:int;
      
      private var beliefMax:int;
      
      private var _totalBloodA:Number;
      
      public var initBloodA:Number = 0;
      
      public var bloodB:int;
      
      public var totalBloodB:Number = 0;
      
      public var initBloodB:Number = 0;
      
      private var _bloodUpdateBuffer:Vector.<BloodUpdateVO>;
      
      private var _bloodUpdateCD:int;
      
      public var skillIds:Array;
      
      public var map:*;
      
      private var _buffers:Vector.<BufferDamageData>;
      
      private var _cacheAction:Array;
      
      protected var _roleView:RoleViewBase;
      
      protected var _actionMovie:ActionMovie = new ActionMovie();
      
      public var _actionManager:BattleActionQueue = new BattleActionQueue();
      
      private var _concurrentActions:Vector.<IAction> = new Vector.<IAction>();
      
      private var _skillQueue:RoleSkillQueue = new RoleSkillQueue(this);
      
      public var _battleModel:BattleModel = BattleManager.getInstance().battleModel;
      
      private var _startload:Boolean;
      
      private var _totalBlood:Number;
      
      private var _riveve:Boolean = false;
      
      public var currentAction:String;
      
      private const S_BUFFER_IDS:Array = [60999];
      
      public var reliveInfo:ReliveInfo;
      
      public function RoleInfo(param1:IEventDispatcher = null)
      {
         super(param1);
         _buffers = new Vector.<BufferDamageData>();
         _bloodUpdateBuffer = new Vector.<BloodUpdateVO>();
         beliefMax = ConfigInfoManager.instance.getBattleGoddessMaxBelief();
      }
      
      public function get bloodA() : Number
      {
         if(_bloodA < 0)
         {
            return 0;
         }
         return _bloodA;
      }
      
      public function get realBloodA() : Number
      {
         var _loc1_:Number = 0;
         for each(var _loc2_:BloodUpdateVO in _bloodUpdateBuffer)
         {
            if(_loc2_.type == 6 || _loc2_.type == 21 || _loc2_.type == 10)
            {
               _loc1_ += _loc2_.blood;
            }
         }
         return _bloodA + _loc1_;
      }
      
      public function set bloodA(param1:Number) : void
      {
         _bloodA = param1;
      }
      
      public function get totalBloodA() : Number
      {
         return _totalBloodA;
      }
      
      public function set totalBloodA(param1:Number) : void
      {
         _totalBloodA = param1;
      }
      
      public function load() : void
      {
         if(_roleView && !_startload)
         {
            _roleView.load();
            _startload = true;
         }
      }
      
      public function reload() : void
      {
         _startload = false;
         load();
      }
      
      public function get startload() : Boolean
      {
         return _startload;
      }
      
      public function initView() : void
      {
      }
      
      public function get isOver() : Boolean
      {
         return BattleActionQueue(_actionManager).isOver;
      }
      
      public function get view() : RoleViewBase
      {
         return _roleView;
      }
      
      public function get side() : int
      {
         return _side;
      }
      
      public function moveForward(param1:Point) : void
      {
         if(scaleX > 0)
         {
            this.point = new Point(this.point.x + param1.x,this.point.y + param1.y);
         }
         else
         {
            this.point = new Point(this.point.x - param1.x,this.point.y + param1.y);
         }
      }
      
      public function set side(param1:int) : void
      {
         _side = param1;
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         _templateId = param1;
      }
      
      public function get blood() : int
      {
         return _currentBlood;
      }
      
      public function get baseBlood() : int
      {
         return _baseBlood;
      }
      
      public function set baseBlood(param1:int) : void
      {
         _baseBlood = param1;
      }
      
      public function get totalBlood() : Number
      {
         return _totalBlood;
      }
      
      public function set totalBlood(param1:Number) : void
      {
         _totalBlood = param1;
         _bloodCalculate = _totalBlood;
      }
      
      public function get bloodCalculate() : int
      {
         return _bloodCalculate;
      }
      
      private function updateBloodCalculate(param1:Number) : void
      {
         _bloodCalculate += param1;
         if(_bloodCalculate < 0)
         {
            _bloodCalculate = 0;
         }
         else if(_bloodCalculate > _totalBlood)
         {
            _bloodCalculate = _totalBlood;
         }
      }
      
      public function updateBlood(param1:Number, param2:int, param3:Boolean = false, param4:int = 6, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false) : void
      {
         var _loc9_:BloodUpdateVO = new BloodUpdateVO();
         _loc9_.blood = param1;
         _loc9_.displayBlood = param2;
         _loc9_.havoc = param3;
         _loc9_.type = param4;
         _loc9_.selfCause = param5;
         _loc9_.defaultSkill = param6;
         _loc9_.parry = param7;
         _loc9_.fire = param8;
         if(_bloodUpdateCD > 0)
         {
            _bloodUpdateBuffer.push(_loc9_);
         }
         else
         {
            realUpdateBlood(_loc9_.blood,_loc9_.displayBlood,_loc9_.havoc,_loc9_.type,_loc9_.selfCause,_loc9_.defaultSkill,_loc9_.parry,_loc9_.fire);
            _bloodUpdateCD = 2;
         }
      }
      
      public function updateBloodSecurity(param1:Number) : void
      {
         bloodA += param1;
         dispatchEvent(new RoleEvent("bloodChangeS",this));
      }
      
      private function realUpdateBlood(param1:Number, param2:int, param3:Boolean = false, param4:int = 6, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false) : void
      {
         if(param4 == 6 || param4 == 21)
         {
            BattleLogSystem.addBloodLogDataII(this,param1);
            _bloodA += param1;
            _currentBlood = bloodA;
         }
         else if(param4 == 7)
         {
            BattleLogSystem.addBloodLogDataII(this,param1);
            bloodB += param1;
            if(bloodB < 0)
            {
               bloodB = 0;
            }
         }
         else if(param4 == 10)
         {
            BattleLogSystem.addBloodLogDataII(this,param1);
            _bloodA += param1;
            _currentBlood = bloodA;
         }
         dispatchEvent(new RoleEvent("bloodChange",{
            "bloodType":param4,
            "blood":param1,
            "displayBlood":param2,
            "havoc":param3,
            "selfCause":param5,
            "isDefault":param6,
            "isParry":param7,
            "isFire":param8
         }));
      }
      
      public function get setVisible() : Boolean
      {
         return _setVisible;
      }
      
      public function get scaleX() : Number
      {
         return _scaleX;
      }
      
      public function set scaleX(param1:Number) : void
      {
         _scaleX = param1;
         dispatchEvent(new RoleEvent("scaleX",param1));
      }
      
      public function get isLiving() : Boolean
      {
         return _isLiving;
      }
      
      private function updateRestrictState() : void
      {
         var _loc3_:BufferDamageData = null;
         var _loc1_:BufferTemplateInfo = null;
         var _loc2_:int = 0;
         if(_restricted)
         {
            _loc2_ = 0;
            while(_loc2_ < _buffers.length)
            {
               _loc3_ = _buffers[_loc2_];
               _loc1_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc3_.templateId);
               if(_loc1_.AttackType == 19)
               {
                  return;
               }
               _loc2_++;
            }
            _restricted = false;
            if(BattleManager.getInstance().battleModel.selfHero == this)
            {
               NotificationManager.instance.sendNotification("restrictChanged");
            }
         }
      }
      
      public function set isLiving(param1:Boolean) : void
      {
         _isLiving = param1;
         if(!_isLiving && _actionMovie)
         {
            _actionMovie.stop();
            die();
         }
         dispatchEvent(new RoleEvent("isLiving",param1));
      }
      
      public function set riveve(param1:Boolean) : void
      {
         _riveve = param1;
         if(_riveve)
         {
            defaultAction = "Stand";
            action("Stand","REPEAT");
         }
      }
      
      public function showDannyEffect(param1:Object) : void
      {
         dispatchEvent(new RoleEvent("effectcPlay",param1));
      }
      
      protected function die() : void
      {
         dispatchEvent(new RoleEvent("die",null));
      }
      
      public function get point() : Point
      {
         var _loc1_:Boolean = false;
         if(!_point)
         {
            _loc1_ = face == 2 ? true : false;
            _point = _loc1_ ? BattleUtils.getPosition(1,pos) : BattleUtils.getPosition(2,pos);
         }
         return _point;
      }
      
      public function set point(param1:Point) : void
      {
         _point = param1.clone();
         _point.x = Math.floor(_point.x);
         _point.y = Math.floor(_point.y);
         dispatchEvent(new RoleEvent("pointChange",_point));
      }
      
      public function initPos(param1:Point) : void
      {
         _point = param1.clone();
         _roleView.initPos(_point);
      }
      
      public function get defaultAction() : String
      {
         return _defaultAction;
      }
      
      public function set defaultAction(param1:String) : void
      {
         _defaultAction = param1;
         if(_actionMovie)
         {
            _action = _actionMovie.defaultAction = param1;
         }
      }
      
      public function get actionMovie() : ActionMovie
      {
         return _actionMovie;
      }
      
      public function get actionMovieClip() : MovieClip
      {
         if(_actionMovie)
         {
            return _actionMovie.movie;
         }
         return null;
      }
      
      public function set actionMovieClip(param1:MovieClip) : void
      {
         var _loc2_:Point = null;
         _actionMovie.movie = param1;
         if(_actionMovie.movie.hasOwnProperty("pos_head"))
         {
            if(_actionMovie.movie.pos_head)
            {
               _loc2_ = new Point(_actionMovie.movie.pos_head.x,_actionMovie.movie.pos_head.y);
            }
            else
            {
               _loc2_ = new Point();
            }
            _specialPosHead = new Point(_loc2_.x,_loc2_.y);
         }
         if(_actionMovie.movie.hasOwnProperty("pos_body"))
         {
            if(_actionMovie.movie.pos_body)
            {
               _loc2_ = new Point(_actionMovie.movie.pos_body.x,_actionMovie.movie.pos_body.y);
            }
            else
            {
               _loc2_ = new Point();
            }
            _specialPosBody = new Point(_loc2_.x,_loc2_.y);
         }
         if(_actionMovie.movie.hasOwnProperty("pos_leg"))
         {
            if(_actionMovie.movie.pos_leg)
            {
               _loc2_ = new Point(_actionMovie.movie.pos_leg.x,_actionMovie.movie.pos_leg.y);
            }
            else
            {
               _loc2_ = new Point();
            }
            _specialPosLeg = new Point(_loc2_.x,_loc2_.y);
         }
         action.apply(null,_cacheAction || [_defaultAction]);
         if(BattleManager.getInstance().battleModel.isNoCharge)
         {
            view.setRoleInfoViewVisible(true);
         }
         view.setColorTransform(_attackMode);
      }
      
      public function action(param1:String, param2:String = null, param3:String = null, param4:int = 5, param5:Boolean = false) : void
      {
         currentAction = param1;
         var _loc6_:Array = [param1,param2,param3,param4,param5];
         if(!_actionMovie || _actionMovie.movie == null)
         {
            _cacheAction = _loc6_;
            return;
         }
         dispatchEvent(new RoleEvent("action",_loc6_));
      }
      
      public function update() : void
      {
         var _loc2_:BloodUpdateVO = null;
         if(_actionManager)
         {
            _actionManager.update();
         }
         if(_skillQueue)
         {
            _skillQueue.update();
         }
         for each(var _loc1_:IAction in _concurrentActions)
         {
            if(_loc1_.finished)
            {
               _concurrentActions.splice(_concurrentActions.indexOf(_loc1_),1);
            }
            else
            {
               _loc1_.update();
            }
         }
         if(_bloodUpdateCD <= 0)
         {
            if(_bloodUpdateBuffer && _bloodUpdateBuffer.length > 0)
            {
               _loc2_ = _bloodUpdateBuffer.shift();
               realUpdateBlood(_loc2_.blood,_loc2_.displayBlood,_loc2_.havoc,_loc2_.type,_loc2_.selfCause,_loc2_.defaultSkill,_loc2_.parry,_loc2_.fire);
               _bloodUpdateCD = 2;
            }
         }
         else if(_bloodUpdateCD > 0)
         {
            _bloodUpdateCD = _bloodUpdateCD - 1;
         }
      }
      
      public function addConcurrentAction(param1:IAction) : void
      {
         _concurrentActions.push(param1);
      }
      
      public function addAction(param1:IAction, param2:Boolean = false) : void
      {
         _actionManager.addAction(param1,param2);
      }
      
      public function addSkill(param1:IAction) : void
      {
         if(_skillQueue == null || param1 == null)
         {
            return;
         }
         _skillQueue.addAction(param1,false);
      }
      
      public function removeActionByType(param1:String) : void
      {
         _actionManager.cancelActionByType(param1);
      }
      
      public function getSkillQueue() : BattleActionQueue
      {
         return _skillQueue;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_roleView);
         _roleView = null;
         ObjectUtils.disposeObject(_actionMovie);
         _actionMovie = null;
         if(_actionManager)
         {
            _actionManager.dispose();
         }
         if(_skillQueue)
         {
            _skillQueue.dispose();
         }
         if(_actionMovie)
         {
            _actionMovie.movie = null;
         }
         _skillQueue = null;
         _actionManager = null;
         _bloodUpdateBuffer = null;
         map = null;
         _battleModel = null;
      }
      
      public function cleanActions() : void
      {
         if(_actionManager)
         {
            BattleActionQueue(_actionManager).cleanActions();
         }
      }
      
      public function get pointZ() : Number
      {
         return _pointZ;
      }
      
      public function set pointZ(param1:Number) : void
      {
         _pointZ = param1;
         dispatchEvent(new RoleEvent("pointChange",param1));
      }
      
      public function get actionManager() : BattleActionQueue
      {
         return _actionManager;
      }
      
      public function get face() : uint
      {
         return _face;
      }
      
      public function set face(param1:uint) : void
      {
         if(_face == param1)
         {
            return;
         }
         _face = param1;
         dispatchEvent(new RoleEvent("FACE_CHANGE",param1));
      }
      
      public function get isLoadComplete() : Boolean
      {
         return _isLoadComplete;
      }
      
      public function set isLoadComplete(param1:Boolean) : void
      {
         _isLoadComplete = param1;
      }
      
      public function setAttactDirection() : void
      {
         if(face == 2)
         {
            direction = "left";
         }
         else
         {
            direction = "right";
         }
      }
      
      public function getSpecialPos(param1:int) : Point
      {
         var _loc2_:Point = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = _specialPosHead;
               break;
            case 1:
               _loc2_ = _specialPosBody;
               break;
            case 2:
               _loc2_ = _specialPosLeg;
               break;
            default:
               _loc2_ = _specialPosBody;
         }
         if(_loc2_)
         {
            return _loc2_.clone();
         }
         return getDefaultPointByPos(param1);
      }
      
      public function getDefaultPointByPos(param1:int) : Point
      {
         var _loc2_:Point = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = new Point(0,-120);
               break;
            case 1:
               _loc2_ = new Point(0,-60);
               break;
            case 2:
               _loc2_ = new Point(0,0);
               break;
            default:
               _loc2_ = new Point(0,-60);
         }
         return _loc2_;
      }
      
      public function get direction() : String
      {
         return _direction;
      }
      
      public function get belief() : int
      {
         return _belief;
      }
      
      public function updateBelief(param1:Number, param2:Boolean = true) : void
      {
         if(belief == param1)
         {
            return;
         }
         _belief = param1;
         if(_belief > beliefMax)
         {
            _belief = beliefMax;
         }
         else if(_belief < 0)
         {
            _belief = 0;
         }
         MsgMan.notifyObserver("GODDESS_BELIEF_CHANGE");
      }
      
      public function addBuffer(param1:BufferDamageData) : void
      {
         var _loc2_:BufferDamageData = null;
         var _loc3_:int = 0;
         var _loc4_:BufferTemplateInfo = null;
         if(_buffers.indexOf(param1) >= 0)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _buffers.length)
         {
            if(_buffers[_loc3_].templateId == param1.templateId && _buffers[_loc3_].targetSkillId == param1.targetSkillId)
            {
               _loc2_ = _buffers[_loc3_];
               break;
            }
            _loc3_++;
         }
         _loc4_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(param1.templateId);
         if(_loc4_.AttackType == 19)
         {
            if(!_restricted)
            {
               _restricted = true;
               if(BattleManager.getInstance().battleModel.selfHero == this)
               {
                  NotificationManager.instance.sendNotification("restrictChanged");
               }
            }
         }
         if(!_loc2_)
         {
            _buffers.push(param1);
            dispatchEvent(new RoleEvent("SHOW_BUFFER",param1));
         }
         else
         {
            copyBufferData(_loc2_,param1);
         }
      }
      
      public function refreshBuffer(param1:BufferDamageData) : void
      {
         var _loc2_:BufferDamageData = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _buffers.length)
         {
            if(_buffers[_loc3_].templateId == param1.templateId)
            {
               _loc2_ = _buffers[_loc3_];
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            copyBufferData(_loc2_,param1);
            dispatchEvent(new RoleEvent("REFRESH_BUFFER",new Vector.<BufferDamageData>().concat(_buffers)));
         }
         else
         {
            addBuffer(param1);
         }
      }
      
      private function copyBufferData(param1:BufferDamageData, param2:BufferDamageData) : void
      {
         param1.processType = param2.processType;
         param1.currentTurn = param2.currentTurn;
         param1.countWay = param2.countWay;
         param1.layerCount = param2.layerCount;
         param1.damages = param2.damages;
      }
      
      public function removeBufferById(param1:int) : void
      {
         var _loc3_:BufferDamageData = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _buffers.length)
         {
            _loc3_ = _buffers[_loc2_];
            if(_loc3_.templateId == param1)
            {
               _buffers.splice(_loc2_,1);
               updateRestrictState();
               dispatchEvent(new RoleEvent("REFRESH_BUFFER",new Vector.<BufferDamageData>().concat(_buffers)));
               break;
            }
            _loc2_++;
         }
      }
      
      public function cleanBuffers(param1:Boolean = true) : void
      {
         var _loc4_:BufferDamageData = null;
         var _loc3_:BufferDamageData = null;
         var _loc2_:Vector.<BufferDamageData> = new Vector.<BufferDamageData>();
         while(_buffers.length > 0)
         {
            _loc3_ = _buffers[0];
            if(BattleManager.getInstance().battleModel.battleType == 310 && !param1 && S_BUFFER_IDS.indexOf(_loc3_.templateId) != -1)
            {
               _loc4_ = _loc3_;
            }
            else if((BattleManager.getInstance().battleModel.battleType == 311 || BattleManager.getInstance().battleModel.battleType == 312 || BattleManager.getInstance().battleModel.battleType == 313) && !param1 && _loc3_.isPermanent)
            {
               _loc2_.push(_loc3_);
            }
            removeBufferById(_loc3_.templateId);
         }
         if(_loc4_)
         {
            _buffers.push(_loc4_);
         }
         if(_loc2_.length > 0)
         {
            _buffers = _buffers.concat(_loc2_);
         }
      }
      
      public function refreshBufferTurn() : void
      {
         var _loc3_:BufferDamageData = null;
         var _loc2_:int = 0;
         var _loc1_:Vector.<BufferDamageData> = getBuffers();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            _loc2_++;
         }
         this.dispatchEvent(new RoleEvent("REFRESH_BUFFER_TURN",null));
         cleanOutTurnBuffer();
      }
      
      public function refreshBufferTurnForDanny(param1:BufferDamageData) : void
      {
         var _loc2_:BufferDamageData = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _buffers.length)
         {
            if(_buffers[_loc3_].templateId == param1.templateId)
            {
               _loc2_ = _buffers[_loc3_];
               if(param1.templateId == 918100000)
               {
                  _loc2_.layerCount = param1.layerCount;
               }
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            this.dispatchEvent(new RoleEvent("REFRESH_BUFFER_TURN",null));
            cleanOutTurnBuffer();
         }
      }
      
      private function cleanOutTurnBuffer() : void
      {
         var _loc4_:BufferDamageData = null;
         var _loc3_:int = 0;
         var _loc1_:Vector.<BufferDamageData> = getBuffers();
         var _loc2_:RoleViewBase = BattleManager.getInstance().battleMap.rolesDict[livingId] as RoleViewBase;
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc4_ = _loc1_[_loc3_];
               if(_loc4_.currentTurn == 0 || _loc4_.countWay == 0)
               {
                  _loc2_.removeBuffer(_loc4_.templateId);
                  _loc3_--;
               }
               _loc3_++;
            }
         }
      }
      
      public function getBuffers() : Vector.<BufferDamageData>
      {
         return _buffers;
      }
      
      public function existUnenableSkillBuffer(param1:int) : Boolean
      {
         for each(var _loc2_:BufferDamageData in _buffers)
         {
            if(_loc2_.unAblesSillIds.indexOf(param1) >= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getPermanentBuffers() : String
      {
         var _loc1_:Array = [];
         for each(var _loc2_:BufferDamageData in _buffers)
         {
            if(_loc2_.isPermanent)
            {
               _loc1_.push(_loc2_.templateId);
            }
         }
         return _loc1_.join(",");
      }
      
      public function pushPermanentBufferDamageDatas(param1:Vector.<BufferDamageData>, param2:Boolean = true) : void
      {
         if(param1 == null)
         {
            param1 = new Vector.<BufferDamageData>();
         }
         if(param2)
         {
            param1.length = 0;
         }
         for each(var _loc3_:BufferDamageData in _buffers)
         {
            if(_loc3_.isPermanent)
            {
               param1.push(_loc3_);
            }
         }
      }
      
      private function getBufferIds() : Vector.<int>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<int> = new Vector.<int>();
         _loc2_ = 0;
         while(_loc2_ < _buffers.length)
         {
            _loc1_.push(_buffers[_loc2_].templateId);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function set direction(param1:String) : void
      {
         if(_direction == param1)
         {
            return;
         }
         _direction = param1;
         dispatchEvent(new RoleEvent("direction_change",_direction));
      }
      
      public function get waitBool() : Boolean
      {
         return affectedSkill == null ? false : true;
      }
      
      public function set attackMode(param1:int) : void
      {
         if(_attackMode == param1)
         {
            return;
         }
         _attackMode = param1;
         if(view)
         {
            view.setColorTransform(_attackMode);
         }
      }
      
      public function get attackMode() : int
      {
         return _attackMode;
      }
      
      public function get restricted() : Boolean
      {
         return _restricted;
      }
      
      public function get moving() : Boolean
      {
         return _moving;
      }
      
      public function set moving(param1:Boolean) : void
      {
         _moving = param1;
      }
      
      private function isContainDannyAction() : Boolean
      {
         if(_actionManager.current is DannyAction)
         {
            return true;
         }
         if(_actionManager.getActions().length > 0 && _actionManager.getActions()[0] is DannyAction)
         {
            return true;
         }
         return false;
      }
      
      public function hideBody() : void
      {
         if(_roleView)
         {
            _roleView.visible = false;
         }
      }
      
      public function showBody() : void
      {
         if(_roleView)
         {
            _roleView.visible = true;
         }
      }
      
      public function hasBuffer(param1:int) : Boolean
      {
         for each(var _loc2_:BufferDamageData in _buffers)
         {
            if(_loc2_.templateId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get roleName() : String
      {
         return "";
      }
      
      public function clone() : RoleInfo
      {
         return null;
      }
      
      public function get isGoddess() : Boolean
      {
         return _isGoddess;
      }
      
      public function set isGoddess(param1:Boolean) : void
      {
         _isGoddess = param1;
      }
   }
}

