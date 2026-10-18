package yishi.actions.goods
{
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.actions.map.MapBaseAction;
   import yishi.datas.goods.GoodsInfo;
   import yishi.scene.SceneManager;
   
   public class BetterGoodsAction extends MapBaseAction
   {
      
      private var _isPop:Boolean;
      
      private var _info:GoodsInfo;
      
      public function BetterGoodsAction(param1:GoodsInfo)
      {
         super();
         _info = param1;
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         var _loc1_:TipMessageData = null;
         if(!_isPop)
         {
            _loc1_ = new TipMessageData();
            _loc1_.title = LanguageMgr.GetTranslation("public.prompt");
            _loc1_.goods = _info;
            _loc1_.type = 2;
            TaskTraceTipManager.instance.showView(_loc1_);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _info = null;
      }
   }
}

