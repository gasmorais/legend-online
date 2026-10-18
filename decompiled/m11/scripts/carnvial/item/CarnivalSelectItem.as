package carnvial.item
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import mvc.module.carnival.CarnivalModel;
   import yishi.manager.CarnivalManager;
   import yishi.manager.PathManager;
   
   public class CarnivalSelectItem extends Sprite implements ISelectable
   {
      
      private var _selectBg:Bitmap;
      
      private var _unSelectBg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _select:Boolean;
      
      private var _isDie:Boolean;
      
      public function CarnivalSelectItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         this.buttonMode = true;
         _selectBg = new Bitmap();
         _unSelectBg = new Bitmap();
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.carnTabTxt");
         addChild(_selectBg);
         addChild(_unSelectBg);
         addChild(_titleTxt);
         var _loc1_:int = int(model.configActId);
         toLoadImg(_selectBg,"tab_select",_loc1_,170);
         toLoadImg(_unSelectBg,"tab_unselect",_loc1_,170);
         selected = false;
      }
      
      public function set titleTab(param1:String) : void
      {
         _titleTxt.text = param1;
      }
      
      private function toLoadImg(param1:Bitmap, param2:String, param3:int, param4:int) : void
      {
         var bit:Bitmap = param1;
         var imgName:String = param2;
         var activeId:int = param3;
         var clipW:int = param4;
         var path:String = PathManager.getCarnivalRes(activeId,imgName);
         LoaderManagerII.instance.load(path,2,0,function(param1:LoaderInfo, param2:Object):void
         {
            var _loc4_:BitmapData = null;
            var _loc3_:Rectangle = null;
            if(!_isDie && param1.args && param2 is Bitmap)
            {
               _loc4_ = new BitmapData(clipW,62);
               _loc3_ = new Rectangle(0,0,clipW,62);
               _loc4_.copyPixels(param2.bitmapData,_loc3_,new Point(0,0));
               param1.args.bitmapData = _loc4_;
            }
         },null,null,bit);
      }
      
      private function get model() : CarnivalModel
      {
         return CarnivalManager.Instance.model;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _select;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _select = param1;
         if(_select)
         {
            _selectBg.visible = true;
            _unSelectBg.visible = false;
            _titleTxt.setFrame(1);
         }
         else
         {
            _selectBg.visible = false;
            _unSelectBg.visible = true;
            _titleTxt.setFrame(2);
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return null;
      }
      
      public function dispose() : void
      {
         if(_isDie)
         {
            return;
         }
         _isDie = true;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_unSelectBg);
         _unSelectBg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

