package map.campaign.view.ui.activevehicle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import yishi.utils.NumberViewUtils;
   
   public class CrossSkillCDNumView extends Sprite implements Disposeable
   {
      
      private static var _redNumBmd:BitmapData;
      
      private static var _yellowNumBmd:BitmapData;
      
      private var _numContainer:Sprite;
      
      public function CrossSkillCDNumView()
      {
         var _loc1_:Bitmap = null;
         super();
         if(!_redNumBmd)
         {
            _loc1_ = ComponentFactory.Instance.creat("asset.vehicle.SkillCDNumRed");
            _redNumBmd = _loc1_.bitmapData;
            _loc1_ = ComponentFactory.Instance.creat("asset.vehicle.SkillCDNumYellow");
            if(_yellowNumBmd)
            {
               _yellowNumBmd.dispose();
            }
            _yellowNumBmd = null;
            _yellowNumBmd = _loc1_.bitmapData;
            _loc1_ = null;
         }
         _numContainer = new Sprite();
         addChild(_numContainer);
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
         while(_numContainer.numChildren > 0)
         {
            _numContainer.removeChildAt(0);
         }
         if(_numContainer && _numContainer.parent)
         {
            removeChild(_numContainer);
         }
         _numContainer = null;
      }
      
      public function setNum(param1:int) : void
      {
         while(_numContainer.numChildren > 0)
         {
            _numContainer.removeChildAt(0);
         }
         var _loc2_:BitmapData = _yellowNumBmd;
         if(param1 < 10)
         {
            _loc2_ = _redNumBmd;
         }
         NumberViewUtils.getNumberView(param1,_numContainer,_loc2_,22,28,22,22,"0123456789.",1);
         _numContainer.x = (44 - _numContainer.width) * 0.5;
         _numContainer.y = (44 - _numContainer.height) * 0.5;
      }
   }
}

