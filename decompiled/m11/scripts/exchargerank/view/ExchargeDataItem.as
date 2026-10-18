package exchargerank.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import mvc.module.exchargerank.ExchargeRankData;
   import mvc.module.exchargerank.ExchargeRankModel;
   import yishi.manager.FrameControllerManager;
   
   public class ExchargeDataItem extends Sprite implements Disposeable, ISelectable, IManualSize
   {
      
      public var _gap:ScaleLeftRightImage;
      
      public var _routineImage:Bitmap;
      
      public var _rankText:FilterFrameText;
      
      public var _userNameText:FilterFrameText;
      
      public var _powerText:FilterFrameText;
      
      public var _agencyServerText:FilterFrameText;
      
      public var _exchargeNumberText:FilterFrameText;
      
      public var _data:ExchargeRankData;
      
      public var _listArray:Array;
      
      private var _model:ExchargeRankModel = FrameControllerManager.instance.exchargeAllControler.model;
      
      public function ExchargeDataItem()
      {
         super();
         initView();
         refreshView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,598,30);
      }
      
      private function initView() : void
      {
         _gap = ComponentFactory.Instance.creatComponentByStylename("exchargerank.dataItem.gap");
         _routineImage = ComponentFactory.Instance.creatBitmap("asset.exchargerank.vipIcon");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.dataItem.rankText");
         _userNameText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.dataItem.userNameText");
         _powerText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.dataItem.levelText");
         _agencyServerText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.agencyServerText");
         _exchargeNumberText = ComponentFactory.Instance.creatComponentByStylename("exchargerank.exchargeNumberText");
         addChild(_gap);
         addChild(_routineImage);
         addChild(_rankText);
         addChild(_userNameText);
         addChild(_powerText);
         addChild(_agencyServerText);
         addChild(_exchargeNumberText);
         _routineImage.visible = false;
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            setValue();
         }
         else
         {
            clear();
         }
      }
      
      private function clear() : void
      {
         _rankText.text = "";
         _userNameText.text = "";
         _powerText.text = "";
         _agencyServerText.text = "";
         _exchargeNumberText.text = "";
      }
      
      private function setValue() : void
      {
         _rankText.text = String(_data.rank);
         _userNameText.text = _data.nickName;
         if(_data.grade != 0)
         {
            _powerText.text = String(_data.grade);
         }
         _agencyServerText.text = _data.agencyServer;
         _exchargeNumberText.text = _data.amount;
         _exchargeNumberText.y = 64 - (_exchargeNumberText.numLines - 1) * 7;
         if(_data.isVip == 1)
         {
            _routineImage.visible = true;
            _userNameText.textColor = 16774656;
         }
      }
      
      public function get data() : ExchargeRankData
      {
         return _data;
      }
      
      public function set data(param1:ExchargeRankData) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_gap);
         _gap = null;
         ObjectUtils.disposeObject(_routineImage);
         _routineImage = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_userNameText);
         _userNameText = null;
         ObjectUtils.disposeObject(_powerText);
         _powerText = null;
         ObjectUtils.disposeObject(_agencyServerText);
         _agencyServerText = null;
         ObjectUtils.disposeObject(_exchargeNumberText);
         _exchargeNumberText = null;
         _data = null;
         _model = null;
         _listArray = [];
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}

