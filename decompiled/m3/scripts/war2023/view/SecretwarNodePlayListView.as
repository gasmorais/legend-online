package war2023.view
{
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.war2023.info.SecretWarNodeInfo;
   import war2023.ui.SecretwarNodePlayListUI;
   
   public class SecretwarNodePlayListView extends SecretwarNodePlayListUI
   {
      
      private var _items:Array = [];
      
      private var _data:SecretWarNodeInfo;
      
      private const MAX_LINE:int = 15;
      
      public function SecretwarNodePlayListView()
      {
         super();
         initData();
      }
      
      public function set data(param1:SecretWarNodeInfo) : void
      {
         _data = param1;
      }
      
      private function initData() : void
      {
         var _loc1_:SecretwarNodePlayInfoView = null;
         var _loc2_:int = 0;
         _nodeInTTxt.text = LanguageMgr.GetTranslation("secretwar.nodeList.title");
         _nodeRedTTxt.text = LanguageMgr.GetTranslation("secretwar.nodeList.red");
         _nodeBlueTTxt.text = LanguageMgr.GetTranslation("secretwar.nodeList.bule");
         _nodeTLNameTxt.text = LanguageMgr.GetTranslation("secretwar.nodeList.name");
         _nodeTLStateTxt.text = LanguageMgr.GetTranslation("secretwar.nodeList.state");
         _nodeTRNameTxt.text = LanguageMgr.GetTranslation("secretwar.nodeList.name");
         _nodeTRStateTxt.text = LanguageMgr.GetTranslation("secretwar.nodeList.state");
         _cantInfo.text = LanguageMgr.GetTranslation("secretwar.cantSee");
         _nodeVbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 15)
         {
            _loc1_ = new SecretwarNodePlayInfoView();
            _nodeVbox.addChild(_loc1_);
            _items.push(_loc1_);
            _loc2_++;
         }
         _nodeVbox.commitChanges();
         _nodeSpanel.invalidateViewport();
      }
      
      public function enterFrame() : void
      {
         var _loc2_:Array = null;
         var _loc4_:Array = null;
         var _loc1_:SecretwarNodePlayInfoView = null;
         var _loc3_:int = 0;
         if(_data)
         {
            if(!_data.isCan)
            {
               _nodeSpanel.visible = false;
               _cantInfo.visible = true;
               return;
            }
            _cantInfo.visible = false;
            _loc2_ = _data.bluePlayerList;
            _loc4_ = _data.redPlayerList;
            _loc3_ = 0;
            while(_loc3_ < 15)
            {
               _loc1_ = _items[_loc3_];
               _loc1_.updateBlue(_loc2_[_loc3_]);
               _loc1_.updateRed(_loc4_[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_:SecretwarNodePlayInfoView in _items)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _items = null;
         super.dispose();
      }
   }
}

