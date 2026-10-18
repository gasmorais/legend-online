package battle.view.skillname
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import org.bytearray.display.ScaleBitmap;
   
   public class SkillNameView extends Sprite
   {
      
      private var _back:ScaleBitmap;
      
      private var _name:DisplayObject;
      
      private var _pos:int = 49;
      
      private var _nameMaxW:int = 294;
      
      private var _bgMaxW:int = 390;
      
      private var _skillNameMC:MovieClip;
      
      public function SkillNameView(param1:int)
      {
         var _loc2_:Bitmap = null;
         _name = BattleManager.getInstance().resourceModel.getSkillName(param1);
         if(_name)
         {
            _name.x = (_nameMaxW - _name.width) * 0.5;
            _loc2_ = ComponentFactory.Instance.creat("asset.battle.SkillNameBg");
            _back = new ScaleBitmap(_loc2_.bitmapData);
            _back.scale9Grid = new Rectangle(40,10,80,10);
            _back.width = _name.width + _pos * 2;
            _back.x = (_bgMaxW - _back.width) * 0.5;
            _back.y = 8;
            _skillNameMC = ComponentFactory.Instance.creat("asset.battle.SkillNameMC");
            _skillNameMC.owner = this;
            _skillNameMC.addFrameScript(_skillNameMC.totalFrames - 1,endFrameFun);
            addChild(_skillNameMC);
            _loc2_.bitmapData = null;
            _loc2_ = null;
         }
         super();
      }
      
      private function endFrameFun() : void
      {
         if(_name)
         {
            if(_name.parent)
            {
               _name.parent.removeChild(_name);
            }
            _name = null;
         }
         if(_skillNameMC)
         {
            _skillNameMC.owner = null;
            _skillNameMC.addFrameScript(_skillNameMC.totalFrames - 1,null);
            _skillNameMC.stop();
            if(_skillNameMC.parent)
            {
               _skillNameMC.parent.removeChild(_skillNameMC);
            }
            _skillNameMC = null;
         }
         if(_back)
         {
            _back.dispose();
            _back = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function showBG(param1:Sprite) : void
      {
         param1.addChild(_back);
      }
      
      public function showName(param1:Sprite) : void
      {
         param1.addChild(_name);
      }
      
      override public function get width() : Number
      {
         return _bgMaxW;
      }
      
      public function dispose() : void
      {
         endFrameFun();
      }
   }
}

