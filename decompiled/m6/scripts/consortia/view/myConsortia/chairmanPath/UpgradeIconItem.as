package consortia.view.myConsortia.chairmanPath
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import mvc.module.consortia.ConsortiaTemplete;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   
   public class UpgradeIconItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _selected:Boolean;
      
      private var _gridBg:Bitmap;
      
      private var _selectedBg:ScaleFrameImage;
      
      private var _grade:int;
      
      private var _numSp:Sprite;
      
      private var _numBitmapData:BitmapData;
      
      public var type:int;
      
      public function UpgradeIconItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         buttonMode = true;
         _gridBg = ComponentFactory.Instance.creatBitmap("asset.consortia.IconBg");
         _numBitmapData = ComponentFactory.Instance.creatBitmapData("asset.consortia.GradeNumImg");
         _selectedBg = ComponentFactory.Instance.creatComponentByStylename("consortia.UpgradeFrameItemBg");
         _selectedBg.setFrame(1);
         _numSp = new Sprite();
         _numSp.x = 45;
         _numSp.y = 40;
         addChild(_gridBg);
         addChild(_selectedBg);
         addChild(_numSp);
      }
      
      public function set grade(param1:int) : void
      {
         _grade = param1;
         if(_grade > 9)
         {
            _numSp.x = 38;
         }
         else
         {
            _numSp.x = 45;
         }
         NumberViewUtils.refreshValue(_grade,_numSp,_numBitmapData,16,21,9,16);
      }
      
      public function get grade() : int
      {
         return _grade;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _numSp = null;
      }
      
      public function get templete() : ConsortiaTemplete
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(type,grade);
      }
      
      public function set back(param1:String) : void
      {
         var _loc2_:DisplayObject = ComponentFactory.Instance.creatBitmap(param1);
         addChildAt(_loc2_,1);
      }
      
      public function dispose() : void
      {
         uninit();
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
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected)
         {
            _selectedBg.setFrame(2);
         }
         else
         {
            _selectedBg.setFrame(1);
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}

