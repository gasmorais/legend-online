package battle.view.ui
{
   import battle.BattleManager;
   import battle.mode.HurtUpMode;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.ChildNswarManager;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.NumberBitmap;
   
   public class HurtUpView extends Sprite
   {
      
      private var _mode:HurtUpMode;
      
      private var _tipBack:ScaleBitmapImage;
      
      private var _tipTxt:FilterFrameText;
      
      private var _countDownBack:DisplayObject;
      
      private var _countDownWord:DisplayObject;
      
      private var _countDownValue:NumberBitmap;
      
      private var _leftChidNsIconBox:HBox;
      
      private var _leftChidNsIconList:Vector.<ChildNswarBattleRoleIcon>;
      
      private var _rightChildNsIconBox:HBox;
      
      private var _rightChildNsIconList:Vector.<ChildNswarBattleRoleIcon>;
      
      private var _childNswarBuffBack:ScaleBitmapImage;
      
      private var _childNswarBuffTxt:FilterFrameText;
      
      private var _childNswarTimeId:int;
      
      private var _lastBufferId:int;
      
      public function HurtUpView(param1:HurtUpMode)
      {
         _mode = param1;
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         _mode.addEventListener("change",onDataChanged);
         NotificationManager.instance.addEventListener("childNswar.Event.Battle",nswarBattleHandler);
      }
      
      private function rmeoveEvent() : void
      {
         _mode.removeEventListener("change",onDataChanged);
         NotificationManager.instance.removeEventListener("childNswar.Event.Battle",nswarBattleHandler);
      }
      
      private function nswarBattleHandler(param1:NotificationEvent = null) : void
      {
         var _loc7_:String = null;
         var _loc2_:ChildNswarBattleRoleIcon = null;
         var _loc6_:SkillTempInfo = null;
         if(!_leftChidNsIconList)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc5_:SimpleDictionary = ChildNswarManager.Instance.model.battleInfo.battleRoleList;
         var _loc8_:int = int(BattleManager.getInstance().battleModel.selfSide);
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc7_ = _loc8_ + "_" + _loc4_;
            _loc2_ = _leftChidNsIconList[_loc4_];
            _loc2_.updateView(_loc5_[_loc7_]);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            if(_loc8_ == 1)
            {
               _loc7_ = "2_" + _loc4_;
            }
            else
            {
               _loc7_ = "1_" + _loc4_;
            }
            _loc2_ = _rightChildNsIconList[_loc4_];
            _loc2_.updateView(_loc5_[_loc7_]);
            _loc4_++;
         }
         var _loc3_:int = int(ChildNswarManager.Instance.model.battleInfo.buffId);
         if(_lastBufferId != _loc3_ && _loc3_ > 0)
         {
            _lastBufferId = _loc3_;
            _loc6_ = TempleteManager.instance.getSkillById(_lastBufferId);
            _childNswarBuffTxt.text = _loc6_.Description;
            _childNswarBuffTxt.height = _childNswarBuffTxt.numLines * 20;
            _childNswarBuffBack.height = _childNswarBuffTxt.height + 25;
         }
      }
      
      private function initView() : void
      {
         var _loc1_:ChildNswarBattleRoleIcon = null;
         var _loc2_:int = 0;
         _tipBack = ComponentFactory.Instance.creatComponentByStylename("ui.battle.battle.BattleHurtUpTipBack");
         addChild(_tipBack);
         _tipBack.visible = false;
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("battle.HurtUpTipTxt");
         addChild(_tipTxt);
         _tipTxt.visible = false;
         _countDownValue = new NumberBitmap();
         _countDownValue.initParams(null,"asset.core.number_img_09",15,19,15,15,"0123456789.",0,0,0,50);
         if(BattleManager.getInstance().battleModel.battleType == 3911)
         {
            _countDownBack = ComponentFactory.Instance.creatBitmap("asset.battle.nswarCdbg");
            addChild(_countDownBack);
            _leftChidNsIconBox = ComponentFactory.Instance.creatComponentByStylename("battle.childnswarLeft.HBox");
            _leftChidNsIconList = new Vector.<ChildNswarBattleRoleIcon>();
            _loc2_ = 0;
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc1_ = new ChildNswarBattleRoleIcon(_loc2_ + 1,1);
               _leftChidNsIconList[_loc2_] = _loc1_;
               _loc2_++;
            }
            _leftChidNsIconBox.beginChanges();
            _loc2_ = 2;
            while(_loc2_ >= 0)
            {
               _loc1_ = _leftChidNsIconList[_loc2_];
               _leftChidNsIconBox.addChild(_loc1_);
               _loc2_--;
            }
            _leftChidNsIconBox.commitChanges();
            addChild(_leftChidNsIconBox);
            _rightChildNsIconBox = ComponentFactory.Instance.creatComponentByStylename("battle.childnswar.right.HBox");
            _rightChildNsIconList = new Vector.<ChildNswarBattleRoleIcon>();
            _rightChildNsIconBox.beginChanges();
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc1_ = new ChildNswarBattleRoleIcon(_loc2_ + 1,2);
               _rightChildNsIconList[_loc2_] = _loc1_;
               _rightChildNsIconBox.addChild(_loc1_);
               _loc2_++;
            }
            _rightChildNsIconBox.commitChanges();
            addChild(_rightChildNsIconBox);
            _childNswarBuffBack = ComponentFactory.Instance.creatComponentByStylename("ui.battle.battle.BattleHurtUpTipBack2");
            _childNswarBuffTxt = ComponentFactory.Instance.creatComponentByStylename("battle.HurtUpTipTxt2");
            addChild(_childNswarBuffBack);
            addChild(_childNswarBuffTxt);
            _countDownValue.y = 14;
            _countDownValue.x = 4;
            nswarBattleHandler();
            _childNswarTimeId = setTimeout(hideBufferhandler,10000);
         }
         else
         {
            _countDownBack = ComponentFactory.Instance.creatBitmap("asset.battle.CountDownBack");
            _countDownWord = ComponentFactory.Instance.creatBitmap("asset.battle.CountDownWords");
            addChild(_countDownBack);
            addChild(_countDownWord);
            _countDownValue.y = 4;
            _countDownValue.x = 36;
         }
         addChild(_countDownValue);
         onDataChanged(null);
      }
      
      private function hideBufferhandler() : void
      {
         if(_childNswarBuffBack)
         {
            _childNswarBuffBack.visible = false;
            _childNswarBuffTxt.visible = false;
         }
      }
      
      private function onDataChanged(param1:Event) : void
      {
         if(_mode.getDamageImprove() > 0)
         {
            _tipTxt.visible = true;
            _tipBack.visible = true;
            if(_mode.battleType == 35 || _mode.battleType == 307)
            {
               _tipTxt.text = LanguageMgr.GetTranslation("battle.hurtUpTip.text2") + " " + _mode.getDamageImprove() + "%";
            }
            else
            {
               _tipTxt.text = LanguageMgr.GetTranslation("battle.hurtUpTip.text") + " " + _mode.getDamageImprove() + "%";
            }
         }
         updateCountDown();
         if(BattleManager.getInstance().battleUIView != null && BattleManager.getInstance().battleUIView.hasGoddessUI)
         {
            _tipBack.y = 118;
            _tipTxt.y = 132;
         }
         else
         {
            _tipBack.y = 58;
            _tipTxt.y = 72;
         }
      }
      
      private function updateCountDown() : void
      {
         var _loc1_:int = int(_mode.getTimeLeft());
         _countDownValue.num = _loc1_;
      }
      
      override public function get width() : Number
      {
         return 318;
      }
      
      public function dispose() : void
      {
         rmeoveEvent();
         clearTimeout(_childNswarTimeId);
         ObjectUtils.disposeObject(_tipBack);
         _tipBack = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         ObjectUtils.disposeObject(_countDownBack);
         _countDownBack = null;
         ObjectUtils.disposeObject(_countDownWord);
         _countDownWord = null;
         ObjectUtils.disposeObject(_countDownValue);
         _countDownValue = null;
         ObjectUtils.disposeObject(_leftChidNsIconBox);
         _leftChidNsIconBox = null;
         ObjectUtils.disposeObject(_rightChildNsIconBox);
         _rightChildNsIconBox = null;
         LogicUtils.disposeDisplayCollection(_leftChidNsIconList);
         _leftChidNsIconList = null;
         LogicUtils.disposeDisplayCollection(_rightChildNsIconList);
         _rightChildNsIconList = null;
         ObjectUtils.disposeObject(_childNswarBuffBack);
         _childNswarBuffBack = null;
         ObjectUtils.disposeObject(_childNswarBuffTxt);
         _childNswarBuffTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

