package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.dreamarena.DreamArenaRankInfo;
   
   public class DreamArenaRankItem extends Component
   {
      
      private var _rankText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _scoreText:FilterFrameText;
      
      private var _line:Image;
      
      private var _data:DreamArenaRankInfo;
      
      public function DreamArenaRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankItem.scoreText");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankItem.rankText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankItem.nameText");
         _line = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankItem.line");
         addChild(_rankText);
         addChild(_nameText);
         addChild(_scoreText);
         addChild(_line);
      }
      
      public function get data() : DreamArenaRankInfo
      {
         return _data;
      }
      
      public function set data(param1:DreamArenaRankInfo) : void
      {
         _data = param1;
         if(data)
         {
            _rankText.text = data.rank + "";
            _nameText.text = data.nickName;
            _scoreText.text = data.score + "";
            _line.visible = true;
         }
         else
         {
            _rankText.text = "";
            _nameText.text = "";
            _scoreText.text = "";
            _line.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_scoreText);
         _scoreText = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         super.dispose();
      }
   }
}

