package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ChesspvpRoleNumUI extends Sprite
   {
      
      protected var _inRoleNumTx:FilterFrameText;
      
      protected var _role1:Bitmap;
      
      protected var _type:int;
      
      private var _max:int;
      
      public function ChesspvpRoleNumUI(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      protected function initView() : void
      {
         _inRoleNumTx = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.inRoleNumTx");
         _role1 = new Bitmap();
         _role1.bitmapData = ChesspvpResourceUtil.ins.roleDataList[_type];
         addChild(_inRoleNumTx);
         addChild(_role1);
         switch(_type - 1)
         {
            case 0:
               _max = 16;
               break;
            case 1:
            case 2:
            case 3:
               _max = 2;
               break;
            case 4:
            case 5:
               _max = 1;
         }
         _inRoleNumTx.text = "0/" + _max;
         _inRoleNumTx.setFrame(1);
      }
      
      public function updateProgress(param1:int) : void
      {
         _inRoleNumTx.text = param1 + "/" + _max;
         if(param1 >= _max)
         {
            _inRoleNumTx.setFrame(1);
         }
         else
         {
            _inRoleNumTx.setFrame(2);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_inRoleNumTx);
         _inRoleNumTx = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

