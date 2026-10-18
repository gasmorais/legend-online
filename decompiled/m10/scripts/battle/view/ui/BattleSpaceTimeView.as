package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   import yishi.datas.BattleModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class BattleSpaceTimeView extends Sprite implements IEnterFrame
   {
      
      private var _back:DisplayObject;
      
      private var _listBox:HBox;
      
      private var _list:Vector.<BattleSpaceTimeBox>;
      
      private var _configBox:String;
      
      private var _configCountBox:String;
      
      private var _configList:Array;
      
      private const MAX:int = 5;
      
      private var _startTime:Number = 0;
      
      private var _passTime:int = 0;
      
      private var _normalConfig:String;
      
      private var _advaneceConfig:String;
      
      private var _normalCountConfig:String;
      
      private var _advaneceCountConfig:String;
      
      private var _isFirst:Boolean = false;
      
      public function BattleSpaceTimeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _normalConfig = TempleteManager.instance.getSpaceTimeBoxConfigValue(1);
         _advaneceConfig = TempleteManager.instance.getSpaceTimeBoxConfigValue(2);
         _normalCountConfig = TempleteManager.instance.getSpaceTimeBoxCountConfigValue(1);
         _advaneceCountConfig = TempleteManager.instance.getSpaceTimeBoxCountConfigValue(2);
         _back = ComponentFactory.Instance.creatBitmap("asset.battle.spaceTimeBoxBK");
         _listBox = ComponentFactory.Instance.creatComponentByStylename("spacetimefalut.battle.RewardHbox");
         addChild(_back);
         addChild(_listBox);
         initBox();
         __layerChangeHandler(null);
      }
      
      private function initBox() : void
      {
         var _loc1_:BattleSpaceTimeBox = null;
         var _loc2_:int = 0;
         _list = new Vector.<BattleSpaceTimeBox>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new BattleSpaceTimeBox();
            _list[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function refreshBoxData() : void
      {
         var _loc1_:BattleSpaceTimeBox = null;
         var _loc3_:int = 0;
         if(_configList == null)
         {
            return;
         }
         var _loc4_:int = (getTimer() - _startTime) / 1000;
         if(_passTime == _loc4_)
         {
            return;
         }
         _passTime = _loc4_;
         var _loc2_:int = int(_listBox.numChildren);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _listBox.getChildAt(_loc3_) as BattleSpaceTimeBox;
            _loc1_.refreshTime(_passTime);
            _loc3_++;
         }
      }
      
      private function startConfigBox(param1:String, param2:String) : void
      {
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc3_:Array = null;
         var _loc7_:int = 0;
         var _loc5_:BattleSpaceTimeBox = null;
         var _loc8_:int = 0;
         if(_configBox == param1 && _configCountBox == param2 || param1 == "" || param1 == null)
         {
            return;
         }
         _configBox = param1;
         _configCountBox = param2;
         _configList = _configBox.split(",");
         var _loc6_:int = int(_configList.length);
         var _loc4_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc5_ = _list[_loc8_];
            _loc9_ = _configList[_loc8_];
            _loc10_ = _loc9_.split(":");
            _loc3_ = param2.split(",");
            _loc5_.initConfig(_loc8_,_loc7_,int(_loc10_[1]),int(_loc10_[0]),_loc3_[_loc8_]);
            _loc7_ = int(_loc10_[1]);
            _loc4_.push(_loc5_);
            _loc8_++;
         }
         ObjectUtils.removeChildAllChildrenFromStage(_listBox);
         _listBox.beginChanges();
         _loc8_ = _loc6_ - 1;
         while(_loc8_ >= 0)
         {
            _loc5_ = _loc4_[_loc8_];
            _listBox.addChild(_loc5_);
            _loc8_--;
         }
         _listBox.commitChanges();
         _listBox.x = (_back.width - _listBox.width) / 2;
      }
      
      private function initEvent() : void
      {
         model.addEventListener("TRAIL_LAYER_CHANGE",__layerChangeHandler);
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         if(model)
         {
            model.removeEventListener("TRAIL_LAYER_CHANGE",__layerChangeHandler);
         }
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         refreshBoxData();
      }
      
      private function __layerChangeHandler(param1:BattleEvent = null) : void
      {
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc3_:String = model.mapId == 9998 ? _normalConfig : _advaneceConfig;
         var _loc2_:String = model.mapId == 9998 ? _normalCountConfig : _advaneceCountConfig;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.split("|");
            _loc5_ = _loc2_.split("|");
            _loc6_ = model.trialLayer - 1 < 0 ? 0 : model.trialLayer - 1;
            startConfigBox(_loc4_[_loc6_],_loc5_[_loc6_]);
            if(!_isFirst)
            {
               _isFirst = true;
               _startTime = getTimer() - beginToNowTime;
            }
            else
            {
               _startTime = getTimer();
            }
         }
      }
      
      private function get beginToNowTime() : Number
      {
         var _loc1_:Date = null;
         var _loc5_:PlayerModel = PlayerManager.instance.currentPlayerModel;
         if(_loc5_.castle_offset == -1)
         {
            _loc1_ = _loc5_.sysCurtime;
         }
         else
         {
            _loc1_ = DateFormatter.getTimezoneOffsetDate(_loc5_.castle_offset);
         }
         var _loc2_:Number = _loc1_.time;
         var _loc4_:Number = Number(_loc5_.playerInfo.spaceTimeBoxTimeBegin);
         return _loc2_ - _loc4_;
      }
      
      private function get model() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         for each(var _loc1_:BattleSpaceTimeBox in _list)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _list = null;
         ObjectUtils.disposeObject(_listBox);
         _listBox = null;
         _configList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

