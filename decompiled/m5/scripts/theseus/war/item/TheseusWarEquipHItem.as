package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusWarEquipHItem extends Sprite
   {
      
      public var _warEquipHbox:HBox;
      
      public var _warEquipType:ScaleFrameImage;
      
      private var _checkBtn:SelectedCheckButton;
      
      private var _itemList:Vector.<TheseusWarEquipCell> = new Vector.<TheseusWarEquipCell>();
      
      private var _maintype:int;
      
      private var _textBack:MutipleImage;
      
      private var _downText:GradientText;
      
      private var _midText:GradientText;
      
      private var _upText:GradientText;
      
      public function TheseusWarEquipHItem(param1:int)
      {
         super();
         _maintype = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:TheseusWarEquipCell = null;
         var _loc3_:int = 0;
         _warEquipHbox = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.warEquipHbox");
         _warEquipType = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.warEquipType");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("theseus.war.equipCheckBtn");
         _textBack = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.textBack" + _maintype);
         _downText = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.posTextdown_" + _maintype);
         _midText = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.posTextmid_" + _maintype);
         _upText = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.posTextup_" + _maintype);
         addChild(_warEquipHbox);
         addChild(_warEquipType);
         addChild(_checkBtn);
         addChild(_textBack);
         addChild(_downText);
         addChild(_midText);
         addChild(_upText);
         _downText.text = LanguageMgr.GetTranslation("ui.theseussoul.posDown");
         _midText.text = LanguageMgr.GetTranslation("ui.theseussoul.posMid");
         _upText.text = LanguageMgr.GetTranslation("ui.theseussoul.posUp");
         _warEquipType.setFrame(_maintype);
         _warEquipHbox.beginChanges();
         var _loc2_:Array = [[1,4,7],[2,5,8],[3,6,9]];
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = new TheseusWarEquipCell(_loc2_[_maintype - 1][_loc3_]);
            _itemList[_loc3_] = _loc1_;
            _warEquipHbox.addChild(_loc1_);
            _loc3_++;
         }
         _warEquipHbox.commitChanges();
      }
      
      public function refreshView(param1:Array) : void
      {
         _checkBtn.selected = TheseussoulManager.Instance.warsoulModel.fightIdx == _maintype;
         for each(var _loc2_:TheseusWarEquipCell in _itemList)
         {
            _loc2_.data = getInfoBySontype(param1,_loc2_.sonType);
         }
      }
      
      private function getInfoBySontype(param1:Array, param2:int) : TheseusWarsoulItemInfo
      {
         for each(var _loc3_:TheseusWarsoulItemInfo in param1)
         {
            if(_loc3_.warTempInfo.SonType == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function initEvent() : void
      {
         _checkBtn.addEventListener("click",checkChooseHandler,false,10);
      }
      
      private function removeEvent() : void
      {
         _checkBtn.removeEventListener("click",checkChooseHandler);
      }
      
      private function checkChooseHandler(param1:Event) : void
      {
         var _loc3_:Boolean = true;
         for each(var _loc2_:TheseusWarEquipCell in _itemList)
         {
            if(_loc2_.data)
            {
               _loc3_ = false;
               break;
            }
         }
         if(_loc3_)
         {
            param1.stopImmediatePropagation();
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.doNofightTip"));
            return;
         }
         if(!_checkBtn.selected)
         {
            TheseussoulManager.Instance.doWarsoulParam(19,_maintype);
         }
         else
         {
            TheseussoulManager.Instance.doWarsoulParam(19,0);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseusWarEquipCell in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_warEquipHbox);
         _warEquipHbox = null;
         ObjectUtils.disposeObject(_warEquipType);
         _warEquipType = null;
         ObjectUtils.disposeObject(_checkBtn);
         _checkBtn = null;
         ObjectUtils.disposeObject(_downText);
         _downText = null;
         ObjectUtils.disposeObject(_midText);
         _midText = null;
         ObjectUtils.disposeObject(_upText);
         _upText = null;
         ObjectUtils.disposeObject(_textBack);
         _textBack = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

