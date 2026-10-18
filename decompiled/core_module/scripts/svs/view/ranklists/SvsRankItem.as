package svs.view.ranklists
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import map.campaign.data.SvsServerInfo;
   
   public class SvsRankItem extends Sprite implements Disposeable
   {
      
      private var _gap:ScaleLeftRightImage;
      
      private var _rankImg:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _data:SvsServerInfo;
      
      public function SvsRankItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _gap = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankItem.ItemGap");
         _rankImg = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankItem.RankImg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankItem.RankTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankItem.NameTxt");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsRankItem.FightPowerTxt");
         addChild(_gap);
         addChild(_rankImg);
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_fightPowerTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function clean() : void
      {
         _rankImg.visible = false;
         _rankTxt.text = "";
         _nameTxt.text = "";
         _fightPowerTxt.text = "";
      }
      
      public function set data(param1:SvsServerInfo) : void
      {
         _data = param1;
         clean();
         if(_data)
         {
            if(_data.finalOrder <= 3)
            {
               _rankImg.setFrame(_data.finalOrder);
               _rankImg.visible = true;
            }
            else
            {
               _rankImg.visible = false;
               _rankTxt.text = _data.finalOrder.toString();
            }
            _nameTxt.text = _data.teamName;
            _fightPowerTxt.text = _data.fightPower.toString();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

