package child.attribute
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import pet.property.PetRenameView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.CastleServiceManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildRenameView extends PetRenameView
   {
      
      public function ChildRenameView()
      {
         super();
      }
      
      override protected function setTypeStr() : void
      {
         _typeStr = "";
      }
      
      override protected function initView() : void
      {
         super.initView();
         _submitBtn.y = 55;
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = 180;
      }
      
      override protected function __submitHandler(param1:MouseEvent) : void
      {
         if(data.fightUserId > 0 && data.fightUserId != playerInfo.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.cannotop"));
            return;
         }
         super.__submitHandler(param1);
      }
      
      override protected function serverCheck() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["nickname"] = _nickName;
         _loc1_["rnd"] = Math.random();
         _loc1_["type"] = 2;
         var _loc2_:String = PathManager.info.REQUEST_PATH + "nicknamecheck";
         LoaderManagerII.instance.load(_loc2_,7,8,__serverCheckResult,null,null,null,_loc1_);
      }
      
      override protected function __serverCheckResult(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:XML = new XML(param2);
         if(String(_loc4_.@value) == "true")
         {
            _loc3_ = int(GoodsManager.instance.findPosById(208043));
            _loc5_ = ChildManager.instance.curSelectChild.name;
            _loc6_ = ChildManager.instance.getJobName(data.job);
            _loc6_ = LanguageMgr.GetTranslation("yishi.view.tips.ThaneTip.ChildrenNameTips",PlayerManager.instance.currentPlayerModel.playerInfo.nickName);
            if(_loc3_ >= 0 || _loc5_ == _loc6_)
            {
               CastleServiceManager.instance.childRename(data.childId,_nickName,_loc3_).onResult = renameResult;
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.attribute.ChildRenameView.noGoods"));
               super.dispose();
            }
         }
         else
         {
            _submitBtn.enable = true;
            _describtTxt.setFrame(1);
            _describtTxt.text = String(_loc4_.@message);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

