package consortia.view.myConsortia.building
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.PlayerManager;
   
   public class ConsortiaPrizeAllotItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _jobIcon:ScaleFrameImage;
      
      private var _nameText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _fightingCapacityText:FilterFrameText;
      
      private var _receivedCountText:FilterFrameText;
      
      private var _receviedCountBg:ScaleFrameImage;
      
      private var _data:ThaneInfo;
      
      private var _count:int;
      
      private var _lastCount:int;
      
      private var _receviedCountTip:StripView;
      
      private var _tips1:String;
      
      private var _tips2:String;
      
      private var _vocationIcon:ScaleFrameImage;
      
      public function ConsortiaPrizeAllotItem()
      {
         super();
         initView();
         initEvents();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,this.width,this.height);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotItemBg");
         _jobIcon = ComponentFactory.Instance.creatComponentByStylename("core.HeroVocation");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotItemName");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotItemGrade");
         _fightingCapacityText = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotItemFC");
         _receivedCountText = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotItemInput");
         _receviedCountBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaPrizeAllotItemInputBg");
         _receviedCountTip = ComponentFactory.Instance.creatCustomObject("consortia.ConsortiaPrizeAllotItemInputTip");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("consortia.PrizeAllot.VocationIcon");
         _jobIcon.x = 10;
         _jobIcon.y = 2;
         _receviedCountBg.setFrame(2);
         _receivedCountText.setFrame(2);
         _tips1 = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaPrizeAllotItem.tips1");
         _tips2 = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaPrizeAllotItem.tips2");
         _vocationIcon.visible = false;
         addChild(_bg);
         addChild(_jobIcon);
         addChild(_nameText);
         addChild(_gradeText);
         addChild(_gradeText);
         addChild(_fightingCapacityText);
         addChild(_receviedCountBg);
         addChild(_receivedCountText);
         addChild(_receviedCountTip);
         addChild(_vocationIcon);
         _receviedCountTip.addChild(createShape());
      }
      
      private function createShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16711680,0);
         _loc1_.graphics.drawRect(0,0,60,21);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function initEvents() : void
      {
         _receivedCountText.addEventListener("keyDown",__keyDownHandler);
         _receivedCountText.addEventListener("focusIn",__focusInHandler);
         _receivedCountText.addEventListener("focusOut",__focusOutHandler);
         _receivedCountText.addEventListener("change",__receivedCountTextChangeHandler);
      }
      
      private function removeEvents() : void
      {
         if(_receivedCountText)
         {
            _receivedCountText.removeEventListener("keyDown",__keyDownHandler);
         }
         if(_receivedCountText)
         {
            _receivedCountText.removeEventListener("focusIn",__focusInHandler);
         }
         if(_receivedCountText)
         {
            _receivedCountText.removeEventListener("focusOut",__focusOutHandler);
         }
         if(_receivedCountText)
         {
            _receivedCountText.removeEventListener("change",__receivedCountTextChangeHandler);
         }
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         if(param1.keyCode == 13)
         {
            changeReceviedCount();
         }
      }
      
      private function __focusInHandler(param1:FocusEvent) : void
      {
         resetReceviedCount();
      }
      
      private function __focusOutHandler(param1:FocusEvent) : void
      {
         changeReceviedCount();
      }
      
      private function __receivedCountTextChangeHandler(param1:Event) : void
      {
         _receivedCountText.text = String(int(_receivedCountText.text));
         if(int(_receivedCountText.text) == 0)
         {
            resetReceviedCount();
         }
      }
      
      private function changeReceviedCount() : void
      {
         if(int(_receivedCountText.text) == 0 && int(_receivedCountText.text) == data.receivedCount)
         {
            resetReceviedCount(true);
            return;
         }
         var _loc1_:int = model.currentPrizeListCount + data.receivedCount;
         _loc1_ = _loc1_ < 10 ? _loc1_ : 10;
         _loc1_ = _loc1_ < int(_receivedCountText.text) ? _loc1_ : int(_receivedCountText.text);
         count = _loc1_;
         _lastCount = data.receivedCount;
         data.receivedCount = count;
         model.currentPrizeListCount = model.currentPrizeListCount + _lastCount - count;
      }
      
      private function resetReceviedCount(param1:Boolean = false) : void
      {
         if(param1)
         {
            _receivedCountText.text = "0";
         }
         _receivedCountText.setSelection(_receivedCountText.text.length,_receivedCountText.text.length);
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         if(_data)
         {
            _loc2_ = int(_data.job > 3 ? _data.job - 3 : _data.job);
            _jobIcon.setFrame(_loc2_);
            _nameText.text = _data.nickName;
            _gradeText.text = LanguageMgr.GetTranslation("public.level2",_data.grades);
            _fightingCapacityText.text = _data.fightingCapacity.toString();
            _receivedCountText.text = _data.receivedCount.toString();
            if(_data.received)
            {
               _receviedCountTip.tipData = _tips2;
               _receviedCountTip.visible = true;
            }
            else
            {
               _receviedCountTip.visible = false;
            }
            refreshRecevied(_data.received);
         }
         refreshVocation();
      }
      
      private function refreshVocation() : void
      {
         if(_data && _data.vocationGrades > 0)
         {
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(ThaneInfoHelper.getJob(_data.job),_data.vocationStep,_data.vocationLevel);
            _vocationIcon.setFrame(_data.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      public function refresh(param1:Boolean = true) : void
      {
         var _loc2_:Boolean = param1 ? param1 : Boolean(data.received);
         var _loc3_:String = param1 ? _tips1 : _tips2;
         _receviedCountTip.tipData = _loc3_;
         _receviedCountTip.visible = _loc2_;
         refreshRecevied(_loc2_);
      }
      
      private function refreshRecevied(param1:Boolean = true) : void
      {
         if(param1)
         {
            _receviedCountBg.setFrame(2);
            _receivedCountText.setFrame(2);
            _receivedCountText.type = "dynamic";
         }
         else
         {
            _receviedCountBg.setFrame(1);
            _receivedCountText.setFrame(1);
            _receivedCountText.type = "input";
         }
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_jobIcon);
         _jobIcon = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_fightingCapacityText);
         _fightingCapacityText = null;
         ObjectUtils.disposeObject(_receivedCountText);
         _receivedCountText = null;
         ObjectUtils.disposeObject(_receviedCountBg);
         _receviedCountBg = null;
         ObjectUtils.disposeObject(_receviedCountTip);
         _receviedCountTip = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

