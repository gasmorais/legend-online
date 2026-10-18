package childpve
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.children.BossInfo;
   import yishi.datas.templates.ChildPveBossTempInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   
   public class ChildPveBossItem extends Component
   {
      
      public var index:int = -1;
      
      private var _selectIndex:int = -1;
      
      private var _isSelected:Boolean = false;
      
      private var _isBeat:Boolean = false;
      
      private var _grayableSprite:Sprite;
      
      private var _bg:Bitmap;
      
      private var _numberImgBg:Bitmap;
      
      private var _drop:Image;
      
      private var _dropSelect:Bitmap;
      
      private var _wanted:Bitmap;
      
      private var _huawen:Bitmap;
      
      private var _wantedHeadFrame:Bitmap;
      
      private var _selectFrame:Bitmap;
      
      private var _beat:Bitmap;
      
      private var _bossNumberMc:MovieClip;
      
      private var _bossNumberBitmapData:BitmapData;
      
      private var _bossNameTxt:FilterFrameText;
      
      private var _headIcon:BaseIconView;
      
      private var shape:Shape;
      
      private var _filter:IFilterFormat;
      
      private var _data:BossInfo;
      
      public function ChildPveBossItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.childpve.bossFrame");
         _numberImgBg = ComponentFactory.Instance.creatBitmap("asset.childpve.numberImgBg");
         _drop = ComponentFactory.Instance.creatComponentByStylename("childpve.drop");
         _dropSelect = ComponentFactory.Instance.creatBitmap("asset.childpve.dropSelect");
         _wanted = ComponentFactory.Instance.creatBitmap("asset.childpve.wanted");
         _huawen = ComponentFactory.Instance.creatBitmap("asset.childpve.huawen");
         _wantedHeadFrame = ComponentFactory.Instance.creatBitmap("asset.childpve.wantedHeadFrame");
         _bossNumberMc = ComponentFactory.Instance.creatCustomObject("childpve.BossNumber");
         _bossNumberBitmapData = ComponentFactory.Instance.creatBitmapData("asset.childpve.number").clone();
         _selectFrame = ComponentFactory.Instance.creatBitmap("asset.childpve.selectFrame");
         _beat = ComponentFactory.Instance.creatBitmap("asset.childpve.beat");
         _bossNameTxt = ComponentFactory.Instance.creatComponentByStylename("childPveBossItem.BossNameTxt");
         _bossNameTxt.isAutoFitLength = true;
         _headIcon = ComponentFactory.Instance.creatCustomObject("childPveBossItem.headIcon");
         _filter = new UIFilter();
         _bossNumberMc.gotoAndStop(1);
         _bossNumberMc.x = 61;
         _bossNumberMc.y = 185;
         _grayableSprite = new Sprite();
         _grayableSprite.addChild(_bg);
         _grayableSprite.addChild(_headIcon);
         _grayableSprite.addChild(_numberImgBg);
         _grayableSprite.addChild(_drop);
         _grayableSprite.addChild(_dropSelect);
         _dropSelect.visible = false;
         _grayableSprite.addChild(_wanted);
         _grayableSprite.addChild(_huawen);
         _grayableSprite.addChild(_wantedHeadFrame);
         _grayableSprite.addChild(_bossNumberMc);
         _grayableSprite.addChild(_bossNameTxt);
         _selectFrame.visible = false;
         _grayableSprite.addChild(_selectFrame);
         addChild(_grayableSprite);
         _beat.visible = false;
         addChild(_beat);
         shape = new Shape();
         shape.x = _bg.x;
         shape.y = _bg.y;
         shape.graphics.lineStyle(1,0,0.1);
         shape.graphics.beginFill(0,0.3);
         shape.graphics.drawRect(0,0,162,183);
         shape.graphics.endFill();
         shape.width = 162;
         shape.height = 183;
         addChild(shape);
         shape.visible = false;
         clean();
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_grayableSprite);
         _grayableSprite = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_numberImgBg);
         _numberImgBg = null;
         ObjectUtils.disposeObject(_drop);
         _drop = null;
         ObjectUtils.disposeObject(_dropSelect);
         _dropSelect = null;
         ObjectUtils.disposeObject(_wanted);
         _wanted = null;
         ObjectUtils.disposeObject(_huawen);
         _huawen = null;
         ObjectUtils.disposeObject(_wantedHeadFrame);
         _wantedHeadFrame = null;
         ObjectUtils.disposeObject(_selectFrame);
         _selectFrame = null;
         ObjectUtils.disposeObject(_beat);
         _beat = null;
         ObjectUtils.disposeObject(_bossNumberMc);
         _bossNumberMc = null;
         ObjectUtils.disposeObject(_bossNumberBitmapData);
         _bossNumberBitmapData = null;
         ObjectUtils.disposeObject(_bossNameTxt);
         _bossNameTxt = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(shape);
         shape = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         _drop.addEventListener("rollOver",__dropOverHandler);
         _drop.addEventListener("rollOut",__dropOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         _drop.removeEventListener("rollOver",__dropOverHandler);
         _drop.removeEventListener("rollOut",__dropOutHandler);
      }
      
      protected function __dropOverHandler(param1:MouseEvent) : void
      {
         _dropSelect.visible = true;
      }
      
      protected function __dropOutHandler(param1:MouseEvent) : void
      {
         _dropSelect.visible = false;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(!isBeat)
         {
            _selectFrame.visible = true;
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _selectFrame.visible = false;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         isSelected = true;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
         if(_isSelected)
         {
            _selectFrame.visible = true;
         }
         else
         {
            _selectFrame.visible = false;
         }
      }
      
      public function hideReward() : void
      {
         if(_drop)
         {
            _drop.visible = false;
         }
      }
      
      public function get isBeat() : Boolean
      {
         return _isBeat;
      }
      
      public function set isBeat(param1:Boolean) : void
      {
         _isBeat = param1;
         if(_isBeat)
         {
            _filter.setGrayFilter(_grayableSprite);
            _beat.visible = true;
            removeEvent();
         }
         else
         {
            _filter.setNormalFilter(_grayableSprite);
            _beat.visible = false;
            addEvent();
         }
      }
      
      public function get data() : BossInfo
      {
         return _data;
      }
      
      public function set data(param1:BossInfo) : void
      {
         _data = param1;
         isBeat = _data.isBeat;
         var _loc2_:ChildPveBossTempInfo = TempleteManager.instance.childPveBossTemplateCate.getTemplateById(_data.tempId);
         NumberViewUtils.refreshValue(_data.grade,_bossNumberMc["content"],_bossNumberBitmapData,13,20,10,13,"0123456789");
         _bossNameTxt.text = _loc2_.bossName;
         _drop.tipData = _loc2_.dropItems;
         _headIcon.icon = IconFactory.getChildPveBossIconPath(_loc2_.icon);
         if(_data)
         {
            addEvent();
            refresh();
         }
         else
         {
            removeEvent();
            clean();
         }
      }
      
      private function refresh() : void
      {
      }
      
      private function clean() : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _data = null;
      }
      
      public function get selectIndex() : int
      {
         return _selectIndex;
      }
      
      public function set selectIndex(param1:int) : void
      {
         _selectIndex = param1;
         if(_selectIndex == -1)
         {
            addEventListener("rollOver",__overHandler);
            addEventListener("rollOut",__outHandler);
            shape.visible = false;
            _selectFrame.visible = false;
            return;
         }
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         if(_selectIndex == index)
         {
            shape.visible = false;
            _selectFrame.visible = true;
         }
         else
         {
            shape.visible = true;
            _selectFrame.visible = false;
         }
      }
   }
}

