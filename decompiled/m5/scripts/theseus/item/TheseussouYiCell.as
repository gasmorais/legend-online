package theseus.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.theseus.AttributeUtils;
   import yishi.datas.templates.TheseusRageTempInfo;
   import yishi.manager.TempleteManager;
   
   public class TheseussouYiCell extends Sprite
   {
      
      private var _yiCellBg:ScaleFrameImage;
      
      private var _cellSelect:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var _icon:Bitmap;
      
      public var pos:int;
      
      private var _level:int;
      
      private var _select:Boolean;
      
      private var _sontype:int;
      
      private var _addLv:int;
      
      private var _addList:Array = [];
      
      public function TheseussouYiCell()
      {
         super();
         initView();
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
         _lvTxt.text = "Lv." + _level;
      }
      
      public function initAddLevel() : void
      {
         _addLv = 0;
         _addList.length = 0;
      }
      
      public function addLevel(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         _addLv += param1;
         var _loc3_:TheseusRageTempInfo = TempleteManager.instance.theseusRageTempCate.getOneTempInfo(pos,param1,2);
         _addList.push(_loc3_);
         var _loc2_:String = "Lv." + _level + AttributeUtils.getColorStr(" +" + _addLv,"#FFF200");
         _lvTxt.htmlText = _loc2_;
      }
      
      public function get addList() : Array
      {
         return _addList;
      }
      
      public function get sontype() : int
      {
         return _sontype;
      }
      
      public function set sontype(param1:int) : void
      {
         _sontype = param1;
         var _loc2_:Array = [2,3];
         if(_loc2_.indexOf(_sontype) != -1)
         {
            _yiCellBg.setFrame(2);
         }
         else
         {
            _yiCellBg.setFrame(1);
         }
         if(_icon == null)
         {
            _icon = ComponentFactory.Instance.creatBitmap("asset.theseus.BIcon" + _sontype);
            addChildAt(_icon,numChildren - 2);
         }
      }
      
      public function set select(param1:Boolean) : void
      {
         _select = param1;
         _cellSelect.visible = _select;
      }
      
      private function initView() : void
      {
         _yiCellBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.yiCellBg");
         _cellSelect = ComponentFactory.Instance.creatBitmap("asset.theseus.cellSelect");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.yiCellLv");
         addChild(_yiCellBg);
         addChild(_lvTxt);
         addChild(_cellSelect);
         _cellSelect.visible = false;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_yiCellBg);
         _yiCellBg = null;
         ObjectUtils.disposeObject(_cellSelect);
         _cellSelect = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _addList = null;
      }
   }
}

