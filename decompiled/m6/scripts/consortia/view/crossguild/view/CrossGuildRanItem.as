package consortia.view.crossguild.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.crossguild.CrossGuildData;
   
   public class CrossGuildRanItem extends Component
   {
      
      private var _rankText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _scoreText:FilterFrameText;
      
      private var _line:Image;
      
      private var _data:CrossGuildData;
      
      public function CrossGuildRanItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRanItem.scoreText");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRanItem.rankText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRanItem.nameText");
         _line = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRanItem.line");
         addChild(_rankText);
         addChild(_nameText);
         addChild(_scoreText);
         addChild(_line);
      }
      
      public function get data() : CrossGuildData
      {
         return _data;
      }
      
      public function set data(param1:CrossGuildData) : void
      {
         _data = param1;
         if(data)
         {
            _rankText.text = data.crossOrder + "";
            _nameText.text = data.consortiaName;
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

