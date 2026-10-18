package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.stele.StelesysInfo;
   import yishi.manager.PlayerManager;
   
   public class StelesysFuzhuBox extends StelesysHexinItem
   {
      
      protected var _lock:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      public function StelesysFuzhuBox()
      {
         super();
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         super.data = param1;
         if(param1 == null)
         {
            _nameTxt.text = "";
            return;
         }
         _nameTxt.htmlText = param1.nameStep;
      }
      
      override protected function initView() : void
      {
         super.initView();
         _lock = ComponentFactory.Instance.creatBitmap("asset.stelesys.lock");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("stelesys.switchNickTxt");
         addChild(_lock);
         addChild(_nameTxt);
      }
      
      override public function set pos(param1:int) : void
      {
         var _loc2_:Boolean = false;
         super.pos = param1;
         var _loc3_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.vocationGrades);
         var _loc4_:int = (_pos - 2) * 5;
         if(_loc3_ >= _loc4_)
         {
            _loc2_ = true;
         }
         _lock.visible = !_loc2_;
         _btnSp.visible = _loc2_;
         _lvBg.visible = _loc2_;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         super.dispose();
      }
   }
}

