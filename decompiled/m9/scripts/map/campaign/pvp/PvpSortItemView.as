package map.campaign.pvp
{
   import chat.view.ChatItemMenu;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import map.campaign.CampaignManager;
   import map.campaign.data.WarFightOrderInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   
   public class PvpSortItemView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _gesteTxt:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _killTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _data:WarFightOrderInfo;
      
      public var mvp:MovieClip;
      
      private var _menu:ChatItemMenu;
      
      public function PvpSortItemView()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("pvpmap.ItemBgImage");
         addChild(_bg);
         _bg.setFrame(1);
         _gesteTxt = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortitem.HonorTxt");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortitem.NickNameTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortitem.ScoreTxt");
         _killTxt = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortitem.KillTxt");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortitem.ServerNameTxt");
         addChild(_nickNameTxt);
         addChild(_serverNameTxt);
         addChild(_scoreTxt);
         addChild(_killTxt);
         addChild(_gesteTxt);
      }
      
      private function addEvent() : void
      {
         _nickNameTxt.addEventListener("link",__onLinkHandler);
      }
      
      private function removeEvent() : void
      {
         _nickNameTxt.removeEventListener("link",__onLinkHandler);
      }
      
      private function __onLinkHandler(param1:TextEvent) : void
      {
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         if(!_data)
         {
            return;
         }
         var _loc4_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc5_:String = _loc4_.serviceName;
         var _loc2_:Boolean = _loc5_ != _data.serverName;
         var _loc3_:Boolean = false;
         _menu = new ChatItemMenu(_data.nickName,_data.userId,_loc3_,_data.serverName,false,false,false,false,false);
         if(SceneManager.instance.currentType == "CASTLE_SCENE")
         {
            if(_loc2_)
            {
               _menu.enablePlayerInfoButton(false);
            }
         }
         LayerManager.Instance.addToLayer(_menu,7);
         _menu.x = StageReferance.stage.mouseX;
         _menu.y = StageReferance.stage.mouseY + 7;
      }
      
      public function set bgFrame(param1:int) : void
      {
      }
      
      public function set data(param1:WarFightOrderInfo) : void
      {
         _data = param1;
         var _loc3_:String = param1.geste > 0 ? "+" + param1.geste : "" + param1.geste;
         _gesteTxt.text = _loc3_;
         _scoreTxt.text = param1.score + "";
         _killTxt.text = param1.hitCount + "";
         _serverNameTxt.text = param1.serverName + "";
         var _loc2_:int = param1.teamId == selfTeamId ? 1 : 2;
         _nickNameTxt.setFrame(_loc2_);
         _nickNameTxt.htmlText = "<a href =\'event: \'><u> " + param1.nickName + " </u></a>";
         _nickNameTxt.mouseEnabled = true;
         if(mvp)
         {
            if(_data.isMvp)
            {
               addChild(mvp);
               mvp.x = _nickNameTxt.x + _nickNameTxt.textWidth + 4 + (_nickNameTxt.width - _nickNameTxt.textWidth) / 2;
            }
            else if(mvp && mvp.parent == this)
            {
               mvp.parent.removeChild(mvp);
            }
         }
      }
      
      private function get selfTeamId() : int
      {
         var _loc1_:Array = CampaignManager.instance.pvpWarFightModel.warFightOrderList;
         for each(var _loc2_:WarFightOrderInfo in _loc1_)
         {
            if(_loc2_.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               return _loc2_.teamId;
            }
         }
         return 1;
      }
      
      override public function get height() : Number
      {
         return 31;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
      }
   }
}

