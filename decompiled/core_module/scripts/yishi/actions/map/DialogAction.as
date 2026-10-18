package yishi.actions.map
{
   import com.pickgliss.toplevel.StageReferance;
   import com.road.yishi.proto.gameplot.PlotInfoMsg;
   import com.road.yishi.proto.gameplot.PlotMsg;
   import dialog.DialogControl;
   import dialog.DialogModel;
   import dialog.data.DialogMessageInfo;
   import manager.LanguageMgr;
   import yishi.comm.PackageIn;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.scene.SceneType;
   
   public class DialogAction extends MapBaseAction
   {
      
      private var _pkg:PackageIn;
      
      private var _count:int;
      
      public function DialogAction(param1:PackageIn)
      {
         super();
         _pkg = param1;
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         if(_count == 1)
         {
            updateImp();
         }
         else if(_count > 600)
         {
            dispose();
         }
         _count = _count + 1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      private function updateImp() : void
      {
         var _loc1_:DialogControl = new DialogControl(dispose,StageReferance.stage);
         _loc1_.model = readPackage();
      }
      
      private function readPackage() : DialogModel
      {
         var _loc4_:int = 0;
         var _loc2_:DialogMessageInfo = null;
         var _loc3_:RegExp = null;
         var _loc5_:DialogModel = new DialogModel();
         var _loc1_:PlotMsg = new PlotMsg();
         _loc1_ = _pkg.readBody(_loc1_) as PlotMsg;
         _loc5_.isLoop = _loc1_.loop;
         _loc5_.scene = SceneType.getSceneTypeById(_loc1_.sceneType);
         _loc4_ = 0;
         while(_loc4_ < _loc1_.info.length)
         {
            _loc2_ = new DialogMessageInfo();
            _loc2_.index = (_loc1_.info[_loc4_] as PlotInfoMsg).index;
            _loc2_.direction = (_loc1_.info[_loc4_] as PlotInfoMsg).direction;
            _loc2_.roleId = (_loc1_.info[_loc4_] as PlotInfoMsg).roleId;
            if(_loc2_.roleId == 0)
            {
               _loc2_.roleId = PlayerManager.instance.currentPlayerModel.playerInfo.pics;
            }
            if((_loc1_.info[_loc4_] as PlotInfoMsg).roleName == "%s")
            {
               (_loc1_.info[_loc4_] as PlotInfoMsg).roleName = PlayerManager.instance.currentPlayerModel.playerInfo.nickName;
            }
            if((_loc1_.info[_loc4_] as PlotInfoMsg).roleName == PlayerManager.instance.currentPlayerModel.userInfo.userId + "$")
            {
               _loc2_.roleName = LanguageMgr.GetTranslation("public.nickName");
            }
            else
            {
               _loc2_.roleName = (_loc1_.info[_loc4_] as PlotInfoMsg).roleName;
            }
            _loc2_.event = (_loc1_.info[_loc4_] as PlotInfoMsg).event;
            _loc2_.param = (_loc1_.info[_loc4_] as PlotInfoMsg).param;
            _loc2_.txt = (_loc1_.info[_loc4_] as PlotInfoMsg).text;
            _loc2_.delayTime = (_loc1_.info[_loc4_] as PlotInfoMsg).delayTime;
            _loc3_ = /%s/g;
            _loc2_.txt = _loc2_.txt.replace(_loc3_,_loc2_.roleName);
            _loc5_.addInfo(_loc2_);
            _loc4_++;
         }
         return _loc5_;
      }
      
      private function transHtmlStr(param1:String) : String
      {
         var _loc3_:RegExp = /&lt;/g;
         var _loc2_:String = param1.replace(_loc3_,"<");
         _loc3_ = /&gt;/g;
         return _loc2_.replace(_loc3_,">");
      }
   }
}

