package secretadventure.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.datas.templates.SecretSonLevelTemplate;
   
   public class SecretAdProgressItem extends Sprite
   {
      
      private var _smallLock:Bitmap;
      
      private var _pass:Bitmap;
      
      private var _bg:ScaleFrameImage;
      
      private var _idx:FilterFrameText;
      
      private var _temp:SecretSonLevelTemplate;
      
      private var _index:int;
      
      public function SecretAdProgressItem()
      {
         super();
         initView();
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      public function get temp() : SecretSonLevelTemplate
      {
         return _temp;
      }
      
      public function set temp(param1:SecretSonLevelTemplate) : void
      {
         _temp = param1;
         if(_temp)
         {
            _idx.text = _temp.MapId + "-" + _index;
         }
      }
      
      public function updateCurrLv(param1:int) : void
      {
         if(_temp)
         {
            _pass.visible = false;
            _bg.setFrame(1);
            if(_temp.LevelId < param1)
            {
               _pass.visible = true;
               _smallLock.visible = false;
            }
            else if(_temp.LevelId == param1)
            {
               _bg.setFrame(2);
               _smallLock.visible = false;
            }
            else
            {
               _smallLock.visible = true;
            }
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.secretadProgress.Bg");
         _smallLock = ComponentFactory.Instance.creatBitmap("asset.secretad.smallLock");
         _pass = ComponentFactory.Instance.creatBitmap("asset.secretad.pass");
         _idx = ComponentFactory.Instance.creatComponentByStylename("ui.secretadProgress.idx");
         addChild(_bg);
         addChild(_smallLock);
         addChild(_pass);
         addChild(_idx);
         _pass.visible = false;
         _bg.setFrame(1);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_smallLock);
         _smallLock = null;
         ObjectUtils.disposeObject(_pass);
         _pass = null;
         ObjectUtils.disposeObject(_idx);
         _idx = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _temp = null;
      }
   }
}

