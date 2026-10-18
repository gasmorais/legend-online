package war2023.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.war2023.info.SecretWarRankInfo;
   import war2023.util.SecretwarBitDataUtil;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarRankOneItem extends Sprite
   {
      
      protected var _data:SecretWarRankInfo;
      
      protected var _selfbg:Bitmap;
      
      private var _line:Bitmap;
      
      private var _rankTxt:FilterFrameText;
      
      private var _rankNameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _attackCountTxt:FilterFrameText;
      
      private var _getBuildTxt:FilterFrameText;
      
      private var _getResTxt:FilterFrameText;
      
      public function SecretwarRankOneItem()
      {
         super();
         initView();
      }
      
      public function set data(param1:SecretWarRankInfo) : void
      {
         _data = param1;
         if(_data == null)
         {
            _rankTxt.text = "";
            _rankNameTxt.text = "";
            _attackCountTxt.text = "";
            _getBuildTxt.text = "";
            _getResTxt.text = "";
            _serverNameTxt.text = "";
            _selfbg.bitmapData = null;
            _line.visible = false;
            return;
         }
         _line.visible = true;
         var _loc2_:String = _data.userId + "_" + _data.serverName;
         if(_loc2_ == SecretWarManager.Instance.model.selfPlay.key)
         {
            _selfbg.bitmapData = SecretwarBitDataUtil.bitDatas[0];
         }
         else
         {
            _selfbg.bitmapData = SecretwarBitDataUtil.bitDatas[_data.camp];
         }
         _rankTxt.text = "" + _data.rank;
         _rankNameTxt.text = _data.nickName;
         if(_data.camp == 1)
         {
            _attackCountTxt.setFrame(1);
            _rankNameTxt.setFrame(1);
            _serverNameTxt.setFrame(1);
            _getBuildTxt.setFrame(1);
            _getResTxt.setFrame(1);
         }
         else
         {
            _attackCountTxt.setFrame(2);
            _rankNameTxt.setFrame(2);
            _serverNameTxt.setFrame(2);
            _getBuildTxt.setFrame(2);
            _getResTxt.setFrame(2);
         }
         _serverNameTxt.text = _data.serverName;
         _attackCountTxt.text = _data.kill.toString();
         _getBuildTxt.text = _data.occupy.toString();
         _getResTxt.text = _data.score.toString();
      }
      
      protected function initView() : void
      {
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(0,0,665,23);
         this.graphics.endFill();
         _line = ComponentFactory.Instance.creatBitmap("asset.DuskAreaPointRankView.PointRankLine");
         _selfbg = new Bitmap();
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankItem.rankTxt");
         _rankNameTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankItem.rankNameTxt");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.RankItem.serverNameTxt");
         _attackCountTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.RankItem.attackCountTxt");
         _getBuildTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.RankItem.getBuildTxt");
         _getResTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.RankItem.getResTxt");
         addChild(_selfbg);
         addChild(_line);
         addChild(_rankTxt);
         addChild(_rankNameTxt);
         addChild(_serverNameTxt);
         addChild(_attackCountTxt);
         addChild(_getBuildTxt);
         addChild(_getResTxt);
         _line.x = 35;
         _line.y = 28;
         _selfbg.y = -5;
      }
      
      public function dispose() : void
      {
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
         ObjectUtils.disposeObject(_getBuildTxt);
         _getBuildTxt = null;
         ObjectUtils.disposeObject(_getResTxt);
         _getResTxt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         _data = null;
      }
   }
}

