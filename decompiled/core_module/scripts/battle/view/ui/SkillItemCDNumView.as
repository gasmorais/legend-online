package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import yishi.utils.BitMapUtil;
   import yishi.utils.NumberViewUtils;
   
   public class SkillItemCDNumView extends Sprite
   {
      
      private var _redNumBmd:BitmapData = _loc4_.bitmapData;
      
      private var _yellowNumBmd:BitmapData = _loc4_.bitmapData;
      
      private var _numContainer:Sprite;
      
      private var _numScale:Number;
      
      private var _iconWidth:Number;
      
      public function SkillItemCDNumView(param1:Number, param2:Number)
      {
         var _loc3_:BitmapData = null;
         _iconWidth = param1;
         _numScale = param2;
         var _loc4_:Bitmap = ComponentFactory.Instance.creat("asset.battle.SkillCDNumRed");
         _loc4_ = ComponentFactory.Instance.creat("asset.battle.SkillCDNumYellow");
         _loc4_ = null;
         if(param2 != 1)
         {
            _loc3_ = BitMapUtil.scaleBitmapData(_redNumBmd,_numScale,_numScale);
            _redNumBmd.dispose();
            _redNumBmd = _loc3_;
            _loc3_ = BitMapUtil.scaleBitmapData(_yellowNumBmd,_numScale,_numScale);
            _yellowNumBmd.dispose();
            _yellowNumBmd = _loc3_;
            _loc3_ = null;
         }
         _numContainer = new Sprite();
         addChild(_numContainer);
         super();
      }
      
      public function setNum(param1:int) : void
      {
         var _loc2_:BitmapData = _yellowNumBmd;
         if(param1 < 10)
         {
            _loc2_ = _redNumBmd;
         }
         NumberViewUtils.getNumberView(param1,_numContainer,_loc2_,22 * _numScale,28 * _numScale,15 * _numScale,22 * _numScale,"0123456789.",1);
         _numContainer.x = (_iconWidth - _numContainer.width) * 0.5;
         _numContainer.y = (_iconWidth - _numContainer.height) * 0.5;
      }
      
      public function dispose() : void
      {
         if(_yellowNumBmd)
         {
            _yellowNumBmd.dispose();
         }
         _yellowNumBmd = null;
         if(_redNumBmd)
         {
            _redNumBmd.dispose();
         }
         _redNumBmd = null;
         ObjectUtils.removeChildAllChildren(_numContainer);
         if(_numContainer && _numContainer.parent)
         {
            removeChild(_numContainer);
         }
         _numContainer = null;
      }
   }
}

