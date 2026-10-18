package map.campaign.view.frame.duskarea
{
   import chat.view.ChatItemMenu;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import map.campaign.data.WarFightOrderInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   
   public class DuskAreaPointRankItem extends Sprite
   {
      
      private var _data:WarFightOrderInfo;
      
      private var _line:Bitmap;
      
      private var _rankTxt:FilterFrameText;
      
      private var _rankNameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _attackCountTxt:FilterFrameText;
      
      private var _getResTxt:FilterFrameText;
      
      private var _menu:ChatItemMenu;
      
      public function DuskAreaPointRankItem()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get data() : WarFightOrderInfo
      {
         return _data;
      }
      
      public function set data(param1:WarFightOrderInfo) : void
      {
         _data = param1;
         if(_data == null)
         {
            _rankTxt.text = "";
            _rankNameTxt.text = "";
            _attackCountTxt.text = "";
            _getResTxt.text = "";
            _serverNameTxt.text = "";
            return;
         }
         _rankTxt.text = data.order.toString();
         _rankNameTxt.text = data.nickName;
         if(data.teamId == 1)
         {
            _rankNameTxt.setFrame(1);
            _serverNameTxt.setFrame(1);
         }
         else
         {
            _rankNameTxt.setFrame(2);
            _serverNameTxt.setFrame(2);
         }
         _serverNameTxt.text = data.serverName;
         _attackCountTxt.text = data.hitCount.toString();
         _getResTxt.text = data.score.toString();
         this.buttonMode = true;
         addEvent();
      }
      
      private function initView() : void
      {
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(0,0,665,23);
         this.graphics.endFill();
         _line = ComponentFactory.Instance.creatBitmap("asset.DuskAreaPointRankView.PointRankLine");
         _line.y = 25;
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankItem.rankTxt");
         _rankNameTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankItem.rankNameTxt");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankItem.serverNameTxt");
         _attackCountTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankItem.attackCountTxt");
         _getResTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankItem.getResTxt");
         addChild(_line);
         addChild(_rankTxt);
         addChild(_rankNameTxt);
         addChild(_serverNameTxt);
         addChild(_attackCountTxt);
         addChild(_getResTxt);
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",onClick);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         if(!data)
         {
            return;
         }
         var _loc4_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc5_:String = _loc4_.serviceName;
         var _loc2_:Boolean = _loc5_ != data.serverName;
         var _loc3_:Boolean = false;
         _menu = new ChatItemMenu(data.nickName,data.userId,_loc3_,data.serverName,false,false,false,false,false,data.uuid);
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
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_rankNameTxt);
         _rankNameTxt = null;
         ObjectUtils.disposeObject(_attackCountTxt);
         _attackCountTxt = null;
         ObjectUtils.disposeObject(_serverNameTxt);
         _serverNameTxt = null;
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         ObjectUtils.disposeObject(_getResTxt);
         _getResTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

